import 'package:flutter/material.dart';

import '../../../feature/checkout/domain/booking_entity.dart';
import '../../../feature/core/historyscreen/sections/historylist/history_list_section.dart';
import '../../colors/app_colors.dart';
import '../card/history_booking_card.dart';
import '../emptyscreen/history_empty_screen.dart';

class HistoryRefreshListView extends StatelessWidget {
  final List<BookingEntity> activeBookings;
  final List<BookingEntity> pastBookings;
  final Future<void> Function() onRefresh;

  const HistoryRefreshListView({
    super.key,
    required this.activeBookings,
    required this.pastBookings,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = activeBookings.isEmpty && pastBookings.isEmpty;

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.primaryBlue,
      child: ListView(
        padding: const EdgeInsets.all(20),
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: [
          if (isEmpty)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: const HistoryEmptyState(),
            )
          else ...[
            // Блок активных записей
            if (activeBookings.isNotEmpty) ...[
              const Text(
                "Активные записи",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlack,
                ),
              ),
              const SizedBox(height: 12),
              ...activeBookings.map(
                (b) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: HistoryBookingCard(
                    booking: b,
                    isDimmed: b.dateTime.isBefore(DateTime.now()) || b.status == 'CANCELED',
                    onCancelSuccess: onRefresh,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Блок истории (прошедших) записей
            if (pastBookings.isNotEmpty) ...[
              HistoryListSection(bookings: pastBookings),
            ],
          ],
        ],
      ),
    );
  }
}
