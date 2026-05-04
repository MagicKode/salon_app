import 'package:flutter/material.dart';
import '../../../../../uikit/colors/app_colors.dart';

class ThemeSelectionSection extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const ThemeSelectionSection({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: isSelected
          ? const Icon(Icons.check, color: AppColors.primaryBlue)
          : null,
    );
  }
}
