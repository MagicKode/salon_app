import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/checkout/sections/price_calculation_section.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../../uikit/widgets/card/expandable_note.dart';
import '../domain/booking_entity.dart';
import 'booking_info_grid.dart';

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

          const SizedBox(height: 5),
          const Divider(thickness: 1.5),
          const SizedBox(height: 5),

          const Text(
            AppStrings.serviceMenuTitle,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),

          // --- СПИСОК УСЛУГ С ЦЕНАМИ ---
          ...booking.services.map(
            (service) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      service.name,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryBlack,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    "${service.price.toStringAsFixed(0)} ${AppStrings.currency}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- НОВАЯ СЕКЦИЯ: ЗАМЕТКИ ---
          if (booking.notes != null && booking.notes!.trim().isNotEmpty) ...[
            const SizedBox(height: 16),

            ExpandableNote(
              note: booking.notes!,
              isInitialExpanded:
                  false, // В окне подтверждения лучше сразу показать текст
            ),
          ],

          const SizedBox(height: 12),
          const Divider(thickness: 1.5),

          PriceCalculationSection(totalPrice: booking.price),
        ],
      ),
    );
  }
}
