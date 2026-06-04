import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../feature/checkout/domain/booking_entity.dart';
import '../../../feature/core/bookingservicescreen/bookingblock/booking_slots_bloc.dart';
import '../../../feature/core/bookingservicescreen/bookingblock/booking_slots_event.dart';
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
    // Пропускаем только со статусом CONFIRMED (отмененные CANCELED уходят)
    final displayActiveBookings =
        activeBookings.where((b) => b.status == 'CONFIRMED').toList();

    final displayPastBookings =
        pastBookings.where((b) => b.status != 'CANCELED').toList();

    final bool isEmpty =
        displayActiveBookings.isEmpty && displayPastBookings.isEmpty;

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
            if (displayActiveBookings.isNotEmpty) ...[
              const Text(
                AppStrings.activeBookings,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlack,
                ),
              ),

              const SizedBox(height: 12),

              ...displayActiveBookings.map(
                (b) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: HistoryBookingCard(
                    booking: b,
                    // проверяем затенение карточки только по текущему времени
                    isDimmed: b.dateTime.isBefore(DateTime.now()),

                    onCancelSuccess: () async {
                      // Сначала пинаем Блок часов, пока контекст на 100% живой
                      context.read<BookingSlotsBloc>().add(
                        LoadBookingSlotsEvent(
                          masterName: b.masterName,
                          date: b.dateTime,
                        ),
                      );
                      // 1. Сначала обновляем список истории на текущем экране
                      await onRefresh();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Блок истории (прошедших) записей
            if (displayPastBookings.isNotEmpty) ...[
              HistoryListSection(bookings: displayPastBookings),
            ],
          ],
        ],
      ),
    );
  }
}
