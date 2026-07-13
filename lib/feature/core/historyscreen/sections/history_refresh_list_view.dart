import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../../uikit/colors/app_colors.dart';
import '../../../../uikit/widgets/card/history_booking_card.dart';
import '../../../../uikit/widgets/emptyscreen/history_empty_screen.dart';
import '../../../checkout/domain/booking_entity.dart';
import '../../bookingservicescreen/bookingblock/booking_slots_bloc.dart';
import '../../bookingservicescreen/bookingblock/booking_slots_event.dart';

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
    // Показываем только CONFIRMED (отменённые скрываем)
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
            // Актуальные записи
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
                    onCancelSuccess: () async {
                      context.read<BookingSlotsBloc>().add(
                        LoadBookingSlotsEvent(
                          masterName: b.masterName,
                          date: b.dateTime,
                        ),
                      );
                      await onRefresh();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Прошедшие записи (без HistoryListSection)
            if (displayPastBookings.isNotEmpty) ...[
              const Text(
                AppStrings.pastBooking,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlack,
                ),
              ),
              const SizedBox(height: 12),
              ...displayPastBookings.map(
                    (b) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: HistoryBookingCard(booking: b),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
