import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../feature/checkout/domain/repository/booking_repository.dart';
import '../../colors/app_colors.dart';

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
    return AlertDialog(
      title: const Text(AppStrings.cancellingBooking),
      content: const Text(AppStrings.confirmationOfCancellingBooking),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            AppStrings.back,
            style: TextStyle(color: AppColors.primaryGrey),
          ),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context); // Сразу закрываем диалог

            // Вызываем отправку запроса на бэк
            final success = await context
                .read<BookingRepository>()
                .cancelBooking(bookingId);

            if (success) {
              if (onCancelSuccess != null) {
                onCancelSuccess!(); // Перерисовываем список
              }
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(AppStrings.successfulDeleted)),
                );
              }
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(AppStrings.errorInDeleteService),
                  ),
                );
              }
            }
          },
          child: const Text(
            AppStrings.cancelDelete,
            style: TextStyle(
              color: AppColors.primaryRed,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
