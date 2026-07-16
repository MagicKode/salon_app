import 'package:flutter/material.dart';

import '../../../config/theme/custom_colors.dart';
import '../../strings/app_strings.dart';

class HistoryEmptyState extends StatelessWidget {
  const HistoryEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.edit_calendar_outlined,
            size: 150,
            color: colors.textSecondary.withOpacity(
              0.5,
            ), // ✅ динамический серый с прозрачностью
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.historyIsEmpty,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: colors.textPrimary, // ✅ динамический чёрный/белый
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.hereWillBeYourBookingStory,
            style: TextStyle(
              fontSize: 14,
              color: colors.textSecondary, // ✅ динамический серый
            ),
          ),
        ],
      ),
    );
  }
}
