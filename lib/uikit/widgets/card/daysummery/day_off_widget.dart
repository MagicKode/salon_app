import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов

class DayOffWidget extends StatelessWidget {
  const DayOffWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    final isToday = _isSameDay(DateTime.now());

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: colors.surfaceInput,
      // ✅ динамический фон
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              Icons.beach_access_rounded,
              size: 48,
              color: colors.textHint.withOpacity(
                0.5,
              ), // ✅ динамический серый с прозрачностью
            ),
            const SizedBox(height: 12),
            Text(
              isToday ? AppStrings.todayIsDayOff : AppStrings.dayOff,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.textSecondary, // ✅ динамический серый
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isToday
                  ? AppStrings.noAppointmentsToday
                  : AppStrings.noAppointmentsOnThisDay,
              style: TextStyle(
                fontSize: 14,
                color: colors.textHint, // ✅ динамический серый (ещё светлее)
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isSameDay(DateTime date) {
    return date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day;
  }
}
