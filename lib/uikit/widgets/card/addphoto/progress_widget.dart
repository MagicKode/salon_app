import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class ProgressWidget extends StatelessWidget {
  final int uploadedCount;
  final int totalCount;
  final double progress;

  const ProgressWidget({
    super.key,
    required this.uploadedCount,
    required this.totalCount,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade200,
            color: AppColors.primaryBlue,
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Загрузка $uploadedCount из $totalCount',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
