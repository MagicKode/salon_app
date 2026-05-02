import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../uikit/assets/app_assets.dart';
import '../../../../uikit/colors/app_colors.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(AppAssets.pavelImg),
          ),
          const SizedBox(height: 16),
          const Text(
            "Павел Ярошенко",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlack,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "+375 (29) 123-45-67",
            style: TextStyle(color: AppColors.primaryGrey, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.profileEmail,
                style: TextStyle(
                  color: AppColors.primaryGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "pavel.yaroshenko@example.com",
                style: TextStyle(color: AppColors.primaryGrey, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
