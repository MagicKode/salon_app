import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class LocationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LocationButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: AppColors.primaryWhite,
      elevation: 4,
      onPressed: onPressed,
      child: const Icon(Icons.gps_fixed, color: AppColors.primaryBlue),
    );
  }
}
