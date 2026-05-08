import 'package:flutter/material.dart';

import '../../../../../../uikit/colors/app_colors.dart';
import '../../../feature/checkout/domain/booking_entity.dart';
import '../../strings/app_strings.dart';
import '../../utils/app_date_formats.dart';
import 'expandable_note.dart';

class HistoryBookingCard extends StatelessWidget {
  final BookingEntity booking;
  final bool isDimmed;

  const HistoryBookingCard({
    super.key,
    required this.booking,
    this.isDimmed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDimmed ? 0.5 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.boxDecorationColor,
          border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // Верхняя часть: Иконка + Инфо + Цена
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Иконка услуги
                Container(
                  padding: const EdgeInsets.all(2),
                  child: const Icon(
                    Icons.content_cut,
                    color: AppColors.primaryBlue,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),

                // 2. Центральный блок (Услуга и Мастер)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.serviceNames,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${AppStrings.labelMaster}: ${booking.masterName}',
                        style: const TextStyle(
                          color: AppColors.primaryBlue,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // 3. Правый блок (Цена)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.payments_outlined,
                          size: 14,
                          color: AppColors.primaryBlue.withOpacity(0.5),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${booking.price} BYN',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.primaryBlue
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 14),

            // 4. Дата
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                AppDateFormats.formatBookingDate(booking.dateTime),
                style: const TextStyle(
                  color: AppColors.primaryBlack,
                  fontSize: 10,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            if (booking.notes != null && booking.notes!.isNotEmpty) ...[
              const SizedBox(height: 12),
              ExpandableNote(note: booking.notes!),
            ],
          ],
        ),
      ),
    );
  }
}
