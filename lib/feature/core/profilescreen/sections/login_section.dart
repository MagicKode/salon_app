import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../../uikit/colors/app_colors.dart';
import '../../../../uikit/widgets/profile_menu_tile.dart';

class LoginSection extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onTap;

  const LoginSection({
    super.key,
    required this.isVisible,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Если пользователь уже вошел, секция просто не отрисовывается
    if (!isVisible) return const SizedBox.shrink();

    return ProfileMenuTile(
      icon: Icons.login_rounded,
      title: AppStrings.loginAccount,
      color: AppColors.primaryBlue,
      onTap: onTap,
    );
  }
}
