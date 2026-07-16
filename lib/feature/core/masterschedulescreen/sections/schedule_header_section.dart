import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../config/theme/custom_colors.dart';

class ScheduleHeaderSection extends StatelessWidget
    implements PreferredSizeWidget {
  const ScheduleHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return AppBar(
      backgroundColor: colors.backgroundPrimary, // ✅ динамический фон
      elevation: 0,
      centerTitle: true,
      title: Text(
        AppStrings.scheduler,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: colors.textPrimary, // ✅ динамический цвет текста
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
