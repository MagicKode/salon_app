import 'package:flutter/material.dart';

import '../../../../config/theme/custom_colors.dart';

class HeaderWidget extends StatelessWidget {
  final int count;
  final bool isUploading;

  const HeaderWidget({
    super.key,
    required this.count,
    required this.isUploading,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Добавить фото',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary, // ✅ динамический цвет текста
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Выберите изображения для портфолио',
                  style: TextStyle(
                    fontSize: 14,
                    color: colors.textSecondary, // ✅ динамический серый
                  ),
                ),
              ],
            ),
          ),
          if (count > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: colors.primaryBlue.withOpacity(0.1),
                // ✅ динамический синий с прозрачностью
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: colors.primaryBlue, // ✅ динамический синий
                ),
              ),
            ),
        ],
      ),
    );
  }
}
