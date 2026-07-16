import 'package:flutter/material.dart';

import '../../../../config/theme/custom_colors.dart';

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
    final colors = Theme.of(context).extension<CustomColors>()!;

    return GestureDetector(
      onTap: onToggle,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: colors.primaryBlue.withOpacity(0.15),
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
              style: TextStyle(
                color: colors.textOnPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
