import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../config/theme/custom_colors.dart';

class EmptyDayWidget extends StatelessWidget {
  const EmptyDayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.coffee,
              size: 100,
              color: colors.textHint.withOpacity(0.5),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.noAppointmentsForSelectedDay,
              style: TextStyle(fontSize: 14, color: colors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
