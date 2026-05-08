import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/profilescreen/profile_body.dart';

import '../../../uikit/colors/app_colors.dart';
import '../../../uikit/strings/app_strings.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryWhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            AppStrings.navProfile,
            style: TextStyle(
              color: AppColors.primaryBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.primaryWhite,
          elevation: 0,
          centerTitle: true,
        ),
        body: const ProfileBody(),
    );
  }
}
