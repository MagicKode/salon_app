import 'package:flutter/material.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../../../uikit/strings/app_strings.dart';
import '../../../../uikit/widgets/search_button.dart';

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
          SearchButton(
            onPressed: () {
              // Логика поиска
            },
          ),
        ],
      ),
    );
  }
}
