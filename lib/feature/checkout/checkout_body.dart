import 'package:flutter/material.dart';
import '../../uikit/colors/app_colors.dart';
import '../../uikit/strings/app_strings.dart';
import '../../uikit/widgets/app_button.dart';
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
              const Text("Ваш заказ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.edit_outlined, size: 18),
                label: const Text("Изменить"),
              ),
            ],
          ),

          const SizedBox(height: 16),
          BookingSummaryCard(booking: booking),
          const SizedBox(height: 24),

          const CashPaymentInfo(),
          const SizedBox(height: 32),

          AppButton(
            text: "Подтвердить бронирование",
            onPressed: () => _onConfirm(context),
          ),
          const SizedBox(height: 12),

          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Отменить и выйти",
              style: TextStyle(color: AppColors.primaryRed, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  void _onConfirm(BuildContext context) {
    Navigator.pop(context); // закрываем checkout
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const BookingSuccessScreen()),
    );
  }
}
