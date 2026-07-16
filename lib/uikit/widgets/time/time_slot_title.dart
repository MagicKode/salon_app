import 'package:flutter/material.dart';

import '../../../config/theme/custom_colors.dart';

/// Приватный виджет для отрисовки одной ячейки (SRP)
class TimeSlotTile extends StatelessWidget {
  final String label;
  final bool isHighlighted;
  final bool isAvailable;
  final VoidCallback? onTap;

  const TimeSlotTile({
    super.key,
    required this.label,
    required this.isHighlighted,
    required this.isAvailable,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    final Color backgroundColor;
    final Color textColor;
    final Border? border;

    if (!isAvailable) {
      // Слот занят – используем тусклые цвета
      backgroundColor = colors.surfaceInput; // светлый фон для занятых
      textColor = colors.textSecondary; // тусклый серый
      border = null;
    } else if (isHighlighted) {
      // Слот выбран – яркий синий
      backgroundColor = colors.primaryBlue;
      textColor = colors.textOnPrimary; // белый на синем
      border = null;
    } else {
      // Свободный, но не выбранный
      backgroundColor = colors.surfaceCard;
      textColor = colors.textPrimary;
      border = Border.all(color: colors.borderLight, width: 1.5);
    }

    return Opacity(
      opacity: isAvailable ? 1.0 : 0.5,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: border,
          boxShadow: isHighlighted || !isAvailable
              ? [
            BoxShadow(
              color: colors.shadow, // ✅ динамическая тень
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isAvailable ? onTap : null,
            borderRadius: BorderRadius.circular(12),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  decoration: !isAvailable ? TextDecoration.lineThrough : null,
                  fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
