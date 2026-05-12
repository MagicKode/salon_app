import 'package:flutter/material.dart';
import '../../../../uikit/colors/app_colors.dart';

class NotificationModel {
  final String title;
  final String body;
  final String time;
  final bool isRead;
  final bool isUrgent;

  NotificationModel({
    required this.title,
    required this.body,
    required this.time,
    this.isRead = false,
    this.isUrgent = false,
  });

  // UI-свойства выносим сюда, чтобы Tile оставался "глупым"
  Color get backgroundColor => isUrgent
      ? AppColors.primaryBlue.withOpacity(0.05)
      : (isRead ? AppColors.boxDecorationColor : AppColors.primaryBackgroundColor);

  Color get borderColor => isRead
      ? AppColors.primaryBlackShadow
      : AppColors.primaryBlue.withOpacity(0.3);

  Color get titleColor => isRead
      ? AppColors.primaryBlack.withOpacity(0.5)
      : AppColors.primaryBlack;
}
