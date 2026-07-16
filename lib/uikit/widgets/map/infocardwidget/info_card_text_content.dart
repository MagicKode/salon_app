import 'package:flutter/material.dart';

import '../../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов

class InfoCardTextContent extends StatelessWidget {
  final String address;

  const InfoCardTextContent({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Адрес крупно
        Text(
          address,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: colors.textOnPrimary, // ✅ всегда контрастный белый/светлый
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        // Подсказка
        Text(
          'Мы находимся здесь',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: colors.textOnPrimary, // ✅ всегда контрастный
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
