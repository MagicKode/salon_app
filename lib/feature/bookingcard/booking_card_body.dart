import 'package:flutter/material.dart';

import 'feature/checkout/sections/booking_summary_card.dart';
import 'feature/checkout/sections/cash_payment_info.dart';

class BookingCardBody extends StatelessWidget {
  const BookingCardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: const [
                BookingSummaryCard(),
                SizedBox(height: 24),
                CashPaymentInfo(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
