import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../../uikit/widgets/history_booking_card.dart';
import '../../../../checkout/domain/booking_entity.dart';

class HistoryListSection extends StatelessWidget {
  final List<BookingEntity> bookings;

  const HistoryListSection({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.pastBooking,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: bookings.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder:
              (context, index) =>
                  HistoryBookingCard(booking: bookings[index], isDimmed: true),
        ),
      ],
    );
  }
}
