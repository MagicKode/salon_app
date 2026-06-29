import 'package:flutter/material.dart';

import '../../colors/app_colors.dart';

class DateCard extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final bool isWeekend;

  const DateCard({
    super.key,
    required this.date,
    required this.isSelected,
    this.isToday = false,
    this.isWeekend = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      decoration: BoxDecoration(
        color:
            isSelected
                ? AppColors.primaryBlue
                : isWeekend
                ? AppColors.primaryRed.withValues(alpha: 0.1)
                : AppColors.boxDecorationColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              isSelected
                  ? AppColors.primaryBlue
                  : isWeekend
                  ? AppColors.primaryRed.withValues(alpha: 0.3)
                  : AppColors.primaryBlue.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            // День недели
            ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'][date.weekday - 1],
            style: TextStyle(
              fontSize: 14,
              color:
                  isSelected
                      ? Colors.white
                      : isWeekend
                      ? AppColors.primaryRed
                      : AppColors.primaryGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${date.day}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color:
                  isSelected
                      ? Colors.white
                      : isWeekend
                      ? AppColors.primaryRed
                      : AppColors.primaryBlack,
            ),
          ),
        ],
      ),
    );
  }
}
