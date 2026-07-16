import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/profilescreen/profile_body.dart';

import '../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов
import '../../../uikit/strings/app_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      backgroundColor: colors.backgroundPrimary, // ✅ динамический фон
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.navProfile,
          style: TextStyle(
            color: colors.textPrimary, // ✅ динамический цвет текста
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: colors.backgroundPrimary,
        // ✅ динамический фон AppBar
        elevation: 0,
        centerTitle: true,
      ),
      body: const ProfileBody(),
    );
  }
}
