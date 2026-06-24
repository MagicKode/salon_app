import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/historyscreen/history_screen.dart';
import 'package:salon_flutter/feature/core/homepagescreen/home_page_screen.dart';
import 'package:salon_flutter/feature/core/masterschedulescreen/master_schedule_screen.dart';

import '../auth/authblock/bloc/auth_block.dart';
import '../auth/authblock/bloc/auth_state.dart';
import '../core/bookingservicescreen/booking_service_screen.dart';
import '../core/catalogscreen/domain/catalog_service.dart';
import '../core/homepagescreen/sections/bottomnavbar/bottom_nav_bar_section.dart';
import '../core/mastercalendarscreen/bloc/master_calendar_bloc.dart';
import '../core/mastercalendarscreen/bloc/master_calendar_event.dart';
import '../core/mastercalendarscreen/master_calendar_screen.dart';
import '../core/notificationscreen/repository/notification_repository.dart';
import '../core/profilescreen/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  int _unreadCount = 0;
  final List<CatalogService> _globalSelectedServices = [];

  @override
  void initState() {
    super.initState();
    _loadUnreadCount();
  }

  void _loadUnreadCount() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      context
          .read<NotificationRepository>()
          .getUnreadCount(authState.user.phoneNumber)
          .then((count) {
        if (mounted) setState(() => _unreadCount = count);
      });
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 1) {
      // Небольшая задержка для завершения анимации
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          final authState = context.read<AuthBloc>().state;
          if (authState is AuthSuccess && authState.user.isMaster) {
            context.read<MasterCalendarBloc>().add(
              FetchTodayAppointments(authState.user.masterName),
            );
          }
        }
      });
    }

    // ✅ Обновляем счётчик при возврате с экрана уведомлений
    if (index == 3) {
      _loadUnreadCount();
    }
  }

  void _handleQuickBooking(CatalogService service) {
    setState(() {
      if (!_globalSelectedServices.any((s) => s.name == service.name)) {
        _globalSelectedServices.add(service);
      }
      _currentIndex = 1; // Переключаем на вторую вкладку
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // 1. Проверяем роль текущего пользователя
        bool isMaster = false;
        if (state is AuthSuccess) {
          isMaster = state.user.role == 'MASTER';
          print('🔑 User role: ${state.user.role}, isMaster: $isMaster');
          print('🔑 User name: ${state.user.name}');
        }

        print(
          '📱 Building MainNavigationScreen. Current index: $_currentIndex, isMaster: $isMaster',
        );

        // 2. Формируем список экранов динамически
        final List<Widget> screens = [
          HomePageScreen(
            isMaster: isMaster,
            onQuickBookRequested: isMaster ? null : _handleQuickBooking,
          ),

          isMaster
              ? const MasterCalendarScreen()
              : BookingServiceScreen(
                key: ValueKey(
                  'booking_screen_${_globalSelectedServices.length}',
                ),
                selectedServices: _globalSelectedServices,
              ),

          isMaster ? const MasterScheduleScreen() : const HistoryScreen(),
          const ProfileScreen(),
        ];

        return Scaffold(
          body: IndexedStack(index: _currentIndex, children: screens),
          bottomNavigationBar: BottomNavBarSection(
            currentIndex: _currentIndex,
            isMaster: isMaster,
            unreadCount: _unreadCount,
            onTap: _onTabTapped,
          ),
        );
      },
    );
  }
}
