import 'package:flutter/material.dart';
import '../../../../uikit/colors/app_colors.dart';
import '../domain/notification_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final bool isExpanded;
  final VoidCallback? onTap;

  const NotificationTile({
    super.key,
    required this.notification,
    this.isExpanded = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: notification.isRead ? AppColors.boxDecorationColor : AppColors.primaryBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: notification.isRead ? AppColors.primaryBlackShadow : AppColors.primaryBlue.withOpacity(0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (!notification.isRead)
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 8, height: 8,
                      decoration: const BoxDecoration(color: AppColors.primaryBlue, shape: BoxShape.circle),
                    ),
                  Expanded(
                    child: Text(notification.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14,
                        color: notification.isRead ? AppColors.primaryBlack.withOpacity(0.5) : AppColors.primaryBlack,
                      ),
                    ),
                  ),
                  Text(notification.timeAgo,
                    style: TextStyle(color: AppColors.primaryGrey, fontSize: 11),
                  ),
                ],
              ),
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(notification.body,
                  style: TextStyle(
                    color: AppColors.primaryBlack.withOpacity(0.8),
                    fontSize: 13, height: 1.4,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
