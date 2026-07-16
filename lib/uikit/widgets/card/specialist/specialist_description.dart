import 'package:flutter/material.dart';

import '../../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов

class SpecialistDescription extends StatelessWidget {
  final String description;

  const SpecialistDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Expanded(
      child: Text(
        description,
        style: TextStyle(
          fontSize: 12,
          color: colors.textSecondary,
          // ✅ динамический серый (вместо полупрозрачного чёрного)
          fontStyle: FontStyle.italic,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
