import 'package:flutter/material.dart';

import '../../../../config/theme/custom_colors.dart';

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
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            backgroundColor: colors.surfaceInput,
            color: colors.statusSuccess,
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Загрузка $uploadedCount из $totalCount',
                style: TextStyle(fontSize: 13, color: colors.textSecondary),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: colors.statusSuccess,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
