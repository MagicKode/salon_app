// Вынесли сложный маркер в отдельный виджет для чистоты кода
import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class UserLocationMarker extends StatelessWidget {
  final double heading;

  const UserLocationMarker({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryBlue.withOpacity(0.2),
          ),
        ),
        AnimatedRotation(
          turns: heading / 360,
          duration: const Duration(milliseconds: 250),
          child: const Icon(
            Icons.navigation,
            color: AppColors.primaryBlue,
            size: 30,
          ),
        ),
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryBlue,
            border: Border.all(color: AppColors.primaryWhite, width: 2),
          ),
        ),
      ],
    );
  }
}
