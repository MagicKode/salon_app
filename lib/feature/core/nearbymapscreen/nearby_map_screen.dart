import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../config/theme/custom_colors.dart';
import 'nearby_map_body.dart';

class NearbyMapScreen extends StatelessWidget {
  const NearbyMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем кастомные цвета темы
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.howToFind,
          style: TextStyle(
            color: colors.textPrimary, // ✅ динамический чёрный/белый
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: colors.backgroundPrimary, // ✅ динамический фон
        elevation: 0,
        centerTitle: true,
      ),
      body: const NearbyMapBody(),
    );
  }
}
