import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов
import '../../../../../uikit/widgets/profile/profile_menu_tile.dart';

class LogoutSection extends StatelessWidget {
  final VoidCallback onConfirm;

  const LogoutSection({super.key, required this.onConfirm});

  void _showLogoutDialog(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Выход из аккаунта',
            style: TextStyle(color: colors.textPrimary), // ✅ динамический цвет
          ),
          content: Text(
            'Вы уверены, что хотите выйти?',
            style: TextStyle(color: colors.textSecondary), // ✅ динамический цвет
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                AppStrings.cancel,
                style: TextStyle(color: colors.textSecondary), // ✅ динамический цвет
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: Text(
                AppStrings.exit,
                style: TextStyle(
                  color: colors.statusError, // ✅ динамический красный
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return ProfileMenuTile(
      icon: Icons.logout_rounded,
      title: AppStrings.exitFromAccount,
      color: colors.statusError, // ✅ динамический красный
      onTap: () => _showLogoutDialog(context),
    );
  }
}
