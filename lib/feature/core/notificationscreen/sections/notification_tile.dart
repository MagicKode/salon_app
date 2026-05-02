import 'package:flutter/material.dart';
import '../../../../uikit/colors/app_colors.dart';
import '../domain/notification_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;

  const NotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: notification.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: notification.borderColor,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    // ТА САМАЯ ТОЧКА
                    if (!notification.isRead)
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryBlue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    Flexible(
                      child: Text(
                        notification.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: notification.titleColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                notification.time,
                style: TextStyle(
                  color: notification.isRead
                      ? AppColors.primaryBlackShadow
                      : AppColors.primaryBlue.withOpacity(0.6),
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            notification.body,
            style: TextStyle(
              color: notification.isRead
                  ? AppColors.primaryBlack.withOpacity(0.4)
                  : AppColors.primaryBlack.withOpacity(0.8),
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
