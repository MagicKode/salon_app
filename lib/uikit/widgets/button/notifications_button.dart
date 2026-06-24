import 'package:flutter/material.dart';
import '../../colors/app_colors.dart';

class NotificationsButton extends StatelessWidget {
  final VoidCallback onTap;
  final int unreadCount;

  const NotificationsButton({
    super.key,
    required this.onTap,
    this.unreadCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_none_rounded, color: AppColors.primaryBlue, size: 30),
          onPressed: onTap,
        ),
        if (unreadCount > 0)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.primaryRed,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryWhite, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
