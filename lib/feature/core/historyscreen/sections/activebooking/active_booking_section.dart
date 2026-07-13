import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import 'package:salon_flutter/uikit/widgets/card/history_booking_card.dart';

import '../../../../../uikit/colors/app_colors.dart';
import '../../../../checkout/domain/booking_entity.dart';

class ActiveBookingSection extends StatelessWidget {
  final List<BookingEntity> bookings;

  const ActiveBookingSection({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.recentBooking, // можно переименовать в "Мои записи"
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlack,
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: bookings.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) => HistoryBookingCard(booking: bookings[index]),
        ),
      ],
    );
  }
}
