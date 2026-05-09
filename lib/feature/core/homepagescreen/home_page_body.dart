import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/appbar/app_bar_section.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/description/description_section.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/feedback/feedback_section.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/searchbar/home_search-bar.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/servicesgrid/service_grid_section.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../nearbymapscreen/nearby_map_screen.dart';
import 'domain/home_models.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  void _navigateToNearbyMap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NearbyMapScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: const AppBarSection(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeSearchBar(onLocationTap: _navigateToNearbyMap),
              const SizedBox(height: 16),
              ServiceGridSection(),
              DescriptionSection(),
              const SizedBox(height: 20),
              FeedbackSection(feedbacks: FeedbackData.items),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
