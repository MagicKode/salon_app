import 'package:flutter/material.dart';

import '../../../../../uikit/colors/app_colors.dart';
import '../../domain/entities/theme_settings_entity.dart';

class ThemeSelectionSection extends StatelessWidget {
  final String title;
  final AppThemeMode currentMode;
  final AppThemeMode modeValue;
  final VoidCallback onTap;

  const ThemeSelectionSection({
    super.key,
    required this.title,
    required this.currentMode,
    required this.modeValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentMode == modeValue;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing:
          isSelected
              ? const Icon(Icons.check, color: AppColors.primaryBlue)
              : null,
    );
  }
}
