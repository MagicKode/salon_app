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
import '../core/mastercalendarscreen/master_calendar_screen.dart';
import '../core/profilescreen/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<CatalogService> _globalSelectedServices = [];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // FIX: Метод должен лежать ТУТ — внутри класса состояния, наравне с _onTabTapped
  void _handleQuickBooking(CatalogService service) {
    setState(() {
      // Проверяем, чтобы услуга не продублировалась в чеке
      if (!_globalSelectedServices.any((s) => s.name == service.name)) {
        _globalSelectedServices.add(service);
      }
      // Мгновенно переключаем нижний бар на вкладку "Бронировать"
      _currentIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // 1. Проверяем роль текущего пользователя
        final bool isMaster =
            state is AuthSuccess &&
            (state as AuthSuccess).toString().contains('master');

        // 2. Формируем список экранов динамически
        final List<Widget> screens = [
          HomePageScreen(
            isMaster: isMaster,
            onQuickBookRequested: _handleQuickBooking,
          ),

          isMaster
              ? const MasterCalendarScreen()
              : BookingServiceScreen(
                // FIX: Передаем живой список, который обновляется глобально
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
            onTap: _onTabTapped,
            isMaster: isMaster,
          ),
        );
      },
    );
  }
}
