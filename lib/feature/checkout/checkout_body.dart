import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../uikit/colors/app_colors.dart';
import '../../uikit/widgets/button/app_button.dart';
import 'booking_success_screen.dart';
import 'domain/booking_entity.dart';
import 'sections/booking_summary_card.dart';
import 'sections/cash_payment_info.dart';

class CheckoutBody extends StatelessWidget {
  final BookingEntity booking;

  const CheckoutBody({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.yourService,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.edit_outlined, size: 18),
                label: const Text(AppStrings.change),
              ),
            ],
          ),

          const SizedBox(height: 12),

          BookingSummaryCard(booking: booking),

          const SizedBox(height: 12),

          const CashPaymentInfo(),

          const SizedBox(height: 12),

          AppButton(
            text: AppStrings.bookingConfirmation,
            onPressed: () => _onConfirm(context),
          ),
          const SizedBox(height: 12),

          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppStrings.cancelAndLeave,
              style: TextStyle(color: AppColors.primaryRed, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  void _onConfirm(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const BookingSuccessScreen()),
    );
  }
}
