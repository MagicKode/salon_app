import 'package:flutter/material.dart';

import '../../colors/app_colors.dart';

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
    final Color backgroundColor;
    final Color textColor;
    final Border? border;

    if (!isAvailable) {
      // Слот занят в базе данных другого клиента
      backgroundColor = Colors.grey.shade100;
      textColor = AppColors.primaryGrey;
      border = null;
    } else if (isHighlighted) {
      // Слот свободен и нажат пользователем
      backgroundColor = AppColors.primaryBlue;
      textColor = AppColors.primaryWhite;
      border = null;
    } else {
      // Слот свободен, но не выбран
      backgroundColor = AppColors.primaryBackgroundColor;
      textColor = AppColors.primaryBlack;
      border = Border.all(color: Colors.grey.shade300, width: 1.5);
    }

    return Opacity(
      opacity: isAvailable ? 1.0 : 0.5,
      // Сделали занятый слот чуть более блеклым (0.5 вместо 0.6) для лучшего контраста
      child: AnimatedContainer(
        // Заменили на AnimatedContainer для плавного изменения цвета при авто-выделении группы слотов
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: border,
          boxShadow:
              isHighlighted || !isAvailable
                  ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            // ИСПРАВЛЕНО: Если слот занят, onTap гарантированно отсутствует, отключая InkWell полностью на уровне движка
            onTap: isAvailable ? onTap : null,
            borderRadius: BorderRadius.circular(12),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  // Занятые слоты визуально перечеркиваем, свободные — чистые
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
