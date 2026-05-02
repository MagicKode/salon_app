import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/app_bar_section.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/description_section.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/feedback_section.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/service_grid_section.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import 'domain/home_models.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
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
