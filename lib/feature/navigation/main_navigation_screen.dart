import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/historyscreen/history_screen.dart';
import 'package:salon_flutter/feature/core/homepagescreen/home_page_screen.dart';
import 'package:salon_flutter/feature/core/masterschedulescreen/master_schedule_screen.dart';

import '../auth/fakeauth/authservice/auth_service.dart';
import '../core/bookingservicescreen/booking_service_screen.dart';
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

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. Проверяем роль текущего пользователя
    final isMaster = AuthService.currentUser?.role == 'master';

    // 2. Формируем список экранов динамически
    final List<Widget> screens = [
      HomePageScreen(isMaster: isMaster),

      isMaster ? const MasterCalendarScreen() : const BookingServiceScreen(),
      isMaster ? const MasterScheduleScreen() : const HistoryScreen(),
      // Меняем экран
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
  }
}
