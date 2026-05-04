import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../bookingcard/bookinghistory/domain/booking_mock_data.dart';
import '../../../bookingcard/bookinghistory/feature/widgets/booking_card.dart';

class ActiveBookingSection extends StatelessWidget {
  const ActiveBookingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.recentBooking,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        BookingCard(booking: BookingMockData.history.first),
      ],
    );
  }
}
