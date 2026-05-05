import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../colors/app_colors.dart';

class DateCard extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isToday;

  const DateCard({
    super.key,
    required this.date,
    required this.isSelected,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryBlue : AppColors.primaryBackgroundColor,
        borderRadius: BorderRadius.circular(40),
        border: isToday && !isSelected
            ? Border.all(color: AppColors.primaryBlue.withOpacity(0.5))
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat.E('ru_RU').format(date),
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? AppColors.primaryWhite : AppColors.primaryBlack,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            date.day.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isSelected ? AppColors.primaryWhite : AppColors.primaryBlack,
            ),
          ),
        ],
      ),
    );
  }
}
