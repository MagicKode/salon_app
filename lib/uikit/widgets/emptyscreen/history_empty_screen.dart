import 'package:flutter/material.dart';

import '../../colors/app_colors.dart';
import '../../strings/app_strings.dart';

class HistoryEmptyState extends StatelessWidget {
  const HistoryEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.edit_calendar_outlined,
            size: 150,
            color: AppColors.primaryGrey.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            AppStrings.historyIsEmpty,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.primaryGrey),
          ),
          const SizedBox(height: 8),
          const Text(
            AppStrings.hereWillBeYourBookingStory,
            style: TextStyle(fontSize: 14, color: AppColors.primaryGrey),
          ),
        ],
      ),
    );
  }
}
