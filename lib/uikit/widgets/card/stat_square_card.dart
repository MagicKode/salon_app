import 'package:flutter/material.dart';
import '../../../../uikit/colors/app_colors.dart';

class StatSquareCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const StatSquareCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryBlue.withOpacity(0.1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primaryBlue, size: 24),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.primaryBlack,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            label,
            style: const TextStyle(
              color: AppColors.primaryGrey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
