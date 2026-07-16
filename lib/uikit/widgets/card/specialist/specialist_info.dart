import 'package:flutter/material.dart';

import '../../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов

class SpecialistInfo extends StatelessWidget {
  final String name;
  final String position;

  const SpecialistInfo({super.key, required this.name, required this.position});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colors.primaryBlue, // ✅ динамический синий
          ),
        ),
        Text(
          position,
          style: TextStyle(
            fontSize: 13,
            color: colors.textSecondary, // ✅ динамический серый для должности
          ),
        ),
      ],
    );
  }
}
