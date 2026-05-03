import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/historyscreen/history_screen.dart';
import 'package:salon_flutter/feature/core/homepagescreen/home_page_screen.dart';

import '../core/bookingservicescreen/booking_service_screen.dart';
import '../core/homepagescreen/sections/bottom_nav_bar_section.dart';
import '../core/profilescreen/profile_screen.dart';
import '../core/servicedetailscreen/sevice_detail_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // Список страниц, между которыми будем переключаться
  final List<Widget> _pages = [
    const HomePageScreen(),
    const BookingServiceScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBarSection(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
