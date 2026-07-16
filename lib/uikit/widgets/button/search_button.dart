import 'package:flutter/material.dart';

import '../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов

class SearchButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SearchButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colors.surfaceCard, // ✅ динамический фон
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          Icons.search,
          color: colors.primaryBlue, // ✅ динамический синий
          size: 24,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
