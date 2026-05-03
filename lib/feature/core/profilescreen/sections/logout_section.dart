import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../../uikit/colors/app_colors.dart';
import '../../../../uikit/widgets/profile_menu_tile.dart';

class LogoutSection extends StatelessWidget {
  final VoidCallback onTap;

  const LogoutSection({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ProfileMenuTile(
      icon: Icons.logout_rounded,
      title: AppStrings.exitFromAccount,
      color: AppColors.primaryRed,
      onTap: onTap,
    );
  }
}
