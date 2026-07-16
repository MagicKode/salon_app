import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов

class ThemeSystemSection extends StatelessWidget {
  final bool isActive;
  final ValueChanged<bool> onChanged;

  const ThemeSystemSection({
    super.key,
    required this.isActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text(
            AppStrings.useSystemTheme,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          value: isActive,
          onChanged: onChanged,
          activeThumbColor: colors.primaryBlue, // ✅ динамический синий
        ),
        Text(
          AppStrings.systemThemeDescription,
          style: TextStyle(
            color: colors.textHint, // ✅ динамический серый для описания
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
