import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/notificationscreen/notifications_screen.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../../auth/loginscreen/login_screen.dart';
import '../../historyscreen/history_screen.dart';

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMenuTile(
          icon: Icons.history,
          title: AppStrings.serviceHistory,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HistoryScreen()),
            );
          },
        ),
        _buildMenuTile(
          icon: Icons.notifications_none_rounded,
          title: AppStrings.notifications,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationsScreen(),
              ),
            );
          },
        ),
        _buildMenuTile(
          icon: Icons.payments_outlined,
          title: AppStrings.payment,
          trailing: Text(
            AppStrings.cash,
            style: TextStyle(
              color: AppColors.primaryBlue,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const Divider(height: 40),
        _buildMenuTile(
          icon: Icons.logout_rounded,
          title: AppStrings.exitFromAccount,
          color: AppColors.primaryRed,
          onTap: () => _showLogoutDialog(context),
        ),
      ],
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
    Color color = AppColors.primaryBlack,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing:
          trailing ??
          (onTap != null
              ? const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.primaryGrey,
              )
              : null),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppColors.primaryWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              AppStrings.exitHeader,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text(AppStrings.confirmationExit),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  AppStrings.cancel,
                  style: TextStyle(color: AppColors.primaryBlackHint),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text(
                  AppStrings.exit,
                  style: TextStyle(
                    color: AppColors.primaryRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
