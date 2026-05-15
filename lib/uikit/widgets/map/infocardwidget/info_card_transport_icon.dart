import 'package:flutter/material.dart';
import '../../../colors/app_colors.dart';

class InfoCardTransportIcon extends StatelessWidget {
  const InfoCardTransportIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.primaryWhite.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.directions_walk,
        color: AppColors.primaryWhite,
        size: 24,
      ),
    );
  }
}
