import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../../../uikit/colors/app_colors.dart';
import '../../../../../uikit/widgets/profile_menu_tile.dart';

class LogoutSection extends StatelessWidget {
  final VoidCallback onConfirm;

  const LogoutSection({super.key, required this.onConfirm});

  // Метод для показа диалога
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Выход из аккаунта'),
          content: const Text('Вы уверены, что хотите выйти?'),
          actions: [

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                AppStrings.cancel,
                style: TextStyle(color: AppColors.primaryGrey),
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: const Text(
                AppStrings.exit,
                style: TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProfileMenuTile(
      icon: Icons.logout_rounded,
      title: AppStrings.exitFromAccount,
      color: AppColors.primaryRed,
      onTap: () => _showLogoutDialog(context),
    );
  }
}
