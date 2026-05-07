import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import 'package:salon_flutter/uikit/widgets/card/history_booking_card.dart';

import '../../../../checkout/domain/booking_entity.dart';
import '../../domain/booking_mock_data.dart';

class ActiveBookingSection extends StatelessWidget {
  final BookingEntity booking;

  const ActiveBookingSection({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.recentBooking,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        HistoryBookingCard(booking: BookingMockData.history.first),
      ],
    );
  }
}
