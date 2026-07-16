import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/checkout/sections/price_calculation_section.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../../config/theme/custom_colors.dart';
import '../../../uikit/widgets/card/expandable_note.dart';
import '../domain/booking_entity.dart';
import 'booking_info_grid.dart';

class BookingSummaryCard extends StatelessWidget {
  final BookingEntity booking;

  const BookingSummaryCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 5,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceCard,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // --- ИНФОРМАЦИОННАЯ СЕТКА (Дата, Время и т.д.) ---
          BookingInfoGrid(
            date: booking.formattedDateTime.split(' - ')[0],
            time: booking.formattedDateTime.split(' - ')[1],
            master: booking.masterName,
            duration: "${booking.durationMinutes} мин",
          ),

          const SizedBox(height: 5),
          const Divider(thickness: 1.5),
          const SizedBox(height: 5),

          // --- ЗАГОЛОВОК СПИСКА УСЛУГ ---
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
                      style: TextStyle(
                        fontSize: 14,
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    "${service.price.toStringAsFixed(0)} ${AppStrings.currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: colors.primaryBlue,
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
              isInitialExpanded:false,
            ),
          ],

          const SizedBox(height: 8),
          const Divider(thickness: 1.5),

          // --- СЕКЦИЯ РАСЧЕТА СТОИМОСТИ (ИТОГО) ---
          PriceCalculationSection(totalPrice: booking.price),
        ],
      ),
    );
  }
}
