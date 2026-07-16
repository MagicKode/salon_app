import 'package:flutter/material.dart';

import '../../../config/theme/custom_colors.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;

  const LoadingWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Анимированный лоадер с красивым дизайном
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: colors.primaryBlue.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    color: colors.primaryBlue,
                    strokeWidth: 3,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              message ?? 'Загрузка...',
              style: TextStyle(fontSize: 16, color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
