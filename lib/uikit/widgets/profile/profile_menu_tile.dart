import 'package:flutter/material.dart';

import '../../../config/theme/custom_colors.dart';

class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? color;

  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;
    final Color effectiveColor = color ?? colors.textPrimary;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: effectiveColor),
      title: Text(
        title,
        style: TextStyle(
          color: effectiveColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing:
          trailing ??
          (onTap != null
              ? Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: colors.textSecondary, // ✅ динамический серый
              )
              : null),
      onTap: onTap,
    );
  }
}
