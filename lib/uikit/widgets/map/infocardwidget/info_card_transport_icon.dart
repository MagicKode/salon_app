import 'package:flutter/material.dart';

import '../../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов

class InfoCardTransportIcon extends StatelessWidget {
  const InfoCardTransportIcon({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: colors.textOnPrimary.withOpacity(0.2), // ✅ динамический контрастный цвет с прозрачностью
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.directions_walk,
        color: colors.textOnPrimary, // ✅ всегда контрастный на синем фоне
        size: 24,
      ),
    );
  }
}
