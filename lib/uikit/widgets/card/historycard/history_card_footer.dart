import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class HistoryCardFooter extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;

  const HistoryCardFooter({
    super.key,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withAlpha(8),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isExpanded ? 'Скрыть ▲' : 'Подробнее ▼',
              style: const TextStyle(color: AppColors.primaryBlue, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
