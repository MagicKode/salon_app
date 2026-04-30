import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/app_bar_section.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/bottom_nav_bar_section.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/description_section.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/feedback_section.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/service_grid_section.dart';

import 'domain/home_models.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key}); // Добавь const конструктор

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBarSection(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AppBarSection(),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              ServiceGridSection(),
              const DescriptionSection(),
              const SizedBox(height: 20),
              FeedbackSection(feedbacks: FeedbackData.items),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
