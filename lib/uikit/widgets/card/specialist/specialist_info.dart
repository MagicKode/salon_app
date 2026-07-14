import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class SpecialistInfo extends StatelessWidget {
  final String name;
  final String position;

  const SpecialistInfo({
    super.key,
    required this.name,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
        ),
        Text(
          position,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.primaryBlack,
          ),
        ),
      ],
    );
  }
}
