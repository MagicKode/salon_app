import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

class NotificationsButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool hasUnread;

  const NotificationsButton({
    super.key,
    required this.onTap,
    this.hasUnread = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: AppColors.boxDecorationColor,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.primaryBlue,
              size: 26,
            ),
            onPressed: onTap,
          ),
        ),
        // Рисуем красную точку, если есть непрочитанные
        if (hasUnread)
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
