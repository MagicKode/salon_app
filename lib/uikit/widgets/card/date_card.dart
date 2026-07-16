import 'package:flutter/material.dart';

import '../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов

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
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    // Определяем цвета в зависимости от состояния
    final Color backgroundColor;
    final Color textColor;
    final Color borderColor;

    if (isSelected) {
      backgroundColor = colors.primaryBlue;
      textColor = colors.textOnPrimary;
      borderColor = colors.primaryBlue;
    } else if (isWeekend) {
      backgroundColor = colors.statusError.withOpacity(0.1);
      textColor = colors.statusError;
      borderColor = colors.statusError.withOpacity(0.3);
    } else {
      backgroundColor = colors.surfaceCard;
      textColor = colors.textPrimary;
      borderColor = colors.primaryBlue.withOpacity(0.3);
    }

    final dayName =
        ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'][date.weekday - 1];

    return Container(
      width: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dayName,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? colors.textOnPrimary : textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${date.day}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected ? colors.textOnPrimary : textColor,
            ),
          ),
        ],
      ),
    );
  }
}
