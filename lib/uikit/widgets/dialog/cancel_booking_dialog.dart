import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов
import '../../../feature/checkout/domain/repository/booking_repository.dart';

class CancelBookingDialog extends StatelessWidget {
  final String bookingId;
  final VoidCallback? onCancelSuccess;

  const CancelBookingDialog({
    super.key,
    required this.bookingId,
    this.onCancelSuccess,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return AlertDialog(
      backgroundColor: colors.backgroundPrimary, // ✅ динамический фон
      title: Text(
        AppStrings.cancellingBooking,
        style: TextStyle(
          color: colors.textPrimary,
        ), // ✅ динамический цвет заголовка
      ),
      content: Text(
        AppStrings.confirmationOfCancellingBooking,
        style: TextStyle(
          color: colors.textSecondary,
        ), // ✅ динамический цвет текста
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            AppStrings.back,
            style: TextStyle(
              color: colors.textSecondary,
            ), // ✅ динамический серый
          ),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);

            final success = await context
                .read<BookingRepository>()
                .cancelBooking(bookingId);

            if (success) {
              if (onCancelSuccess != null) {
                onCancelSuccess!();
              }
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppStrings.successfulDeleted,
                      style: TextStyle(color: colors.textOnPrimary),
                    ),
                    backgroundColor: colors.statusSuccess,
                  ),
                );
              }
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppStrings.errorInDeleteService,
                      style: TextStyle(color: colors.textOnPrimary),
                    ),
                    backgroundColor: colors.statusError,
                  ),
                );
              }
            }
          },
          child: Text(
            AppStrings.cancelDelete,
            style: TextStyle(
              color: colors.statusError,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
