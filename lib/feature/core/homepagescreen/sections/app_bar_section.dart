import 'package:flutter/material.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../../../uikit/strings/app_strings.dart';

class AppBarSection extends StatelessWidget {
  const AppBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                AppStrings.homeWelcome,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                AppStrings.homeSubtitle,
                style: TextStyle(color: AppColors.primaryGrey, fontSize: 16),
              ),
            ],
          ),
          _SearchButton(),
        ],
      ),
    );
  }

  Widget _SearchButton() {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: AppColors.boxDecorationColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(
          Icons.search,
          color: AppColors.primaryBlue,
          size: 24,
        ),
        onPressed: () {
          // Логика поиска
        },
      ),
    );
  }
}
