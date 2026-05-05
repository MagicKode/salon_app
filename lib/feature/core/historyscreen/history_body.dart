import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/historyscreen/sections/activebooking/active_booking_section.dart';

import '../../checkout/domain/booking_entity.dart';
import 'domain/booking_mock_data.dart';
import 'sections/historylist/history_list_section.dart';

class HistoryBody extends StatelessWidget {
  const HistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    final allBookings = BookingMockData.history;

    final nearestBooking = allBookings.isNotEmpty ? allBookings.first : null;

    final List<BookingEntity> otherBookings = allBookings.isNotEmpty
        ? allBookings.skip(1).toList().cast<BookingEntity>()
        : [];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        if (nearestBooking != null)
          ActiveBookingSection(booking: nearestBooking),

        const SizedBox(height: 24),

        if (otherBookings.isNotEmpty)
          HistoryListSection(bookings: otherBookings),
      ],
    );
  }
}
