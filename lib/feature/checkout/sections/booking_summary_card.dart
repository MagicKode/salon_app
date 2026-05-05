import 'package:flutter/material.dart';
import '../../../../uikit/colors/app_colors.dart';
import '../domain/booking_entity.dart';
import 'booking_info_grid.dart';
import 'price_calculation_section.dart';

class BookingSummaryCard extends StatelessWidget {
  final BookingEntity booking;

  const BookingSummaryCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.boxDecorationColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookingInfoGrid(
            date: booking.formattedDateTime.split(' - ')[0],
            time: booking.formattedDateTime.split(' - ')[1],
            master: booking.masterName,
            duration: "${booking.durationMinutes} мин",
          ),
          const SizedBox(height: 20),
          const Divider(thickness: 1.5),
          const SizedBox(height: 20),
          const Text(
            "Услуги",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          PriceCalculationSection(totalPrice: booking.price),
        ],
      ),
    );
  }
}