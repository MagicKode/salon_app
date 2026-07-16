import 'package:flutter/material.dart';

import '../../../config/theme/custom_colors.dart';

class NetworkErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final String? buttonText;

  const NetworkErrorWidget({
    super.key,
    this.message = 'Нет подключения к интернету',
    required this.onRetry,
    this.buttonText = 'Повторить',
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Иконка без интернета
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: colors.statusError.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                size: 56,
                color: colors.statusError.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 24),

            // Заголовок
            Text(
              'Нет интернета',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),

            // Описание
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: colors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),

            // Кнопка "Повторить"
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primaryBlue,
                foregroundColor: colors.textOnPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.refresh_rounded, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    buttonText!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Подсказка
            Text(
              'Проверьте подключение к сети',
              style: TextStyle(fontSize: 12, color: colors.textHint),
            ),
          ],
        ),
      ),
    );
  }
}
