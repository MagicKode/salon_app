import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов

class ServiceDescriptionSection extends StatelessWidget {
  final String description;

  const ServiceDescriptionSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.descriptionHeader,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary, // ✅ динамический цвет заголовка
          ),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            color: colors.textPrimary, // ✅ динамический цвет текста
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
