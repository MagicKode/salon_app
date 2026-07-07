import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

class EmptyDayWidget extends StatelessWidget {
  const EmptyDayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade50, // 🔥 как у календаря
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 0.5),
      ),
      child: Column(
        children: [
          Icon(
            Icons.coffee,
            size: 80,
            color: AppColors.primaryGrey.withOpacity(0.5),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.noAppointmentsForSelectedDay,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.dateGrey,
            ),
          ),
        ],
      ),
    );
  }
}