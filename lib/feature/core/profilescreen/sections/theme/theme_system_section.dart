// uikit/widgets/theme_system_section.dart
import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../../../uikit/colors/app_colors.dart';

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
          activeColor: AppColors.primaryBlue,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            AppStrings.systemThemeDescription,
            style: TextStyle(
              color: AppColors.primaryGrey,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}