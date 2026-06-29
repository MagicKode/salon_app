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
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        // Небольшая рамка добавит четкости при увеличении текста
        border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.1)),
      ),
      child: Stack(
        children: [

          // 1. Иконка в углу
          Positioned(
            top: 6,
            right: 6,
            child: Icon(
              icon,
              size: 18,
              color: AppColors.primaryBlue.withValues(alpha: 0.5),
            ),
          ),

          // 2. Основной контент по центру
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlack,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
