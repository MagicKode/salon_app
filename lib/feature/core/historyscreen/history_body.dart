import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/theme/custom_colors.dart';
import '../../../uikit/colors/app_colors.dart';
import '../../../uikit/widgets/card/historycard/historybookingcard/history_booking_card.dart';
import '../../../uikit/widgets/emptyscreen/history_empty_screen.dart';
import '../../checkout/domain/booking_entity.dart';
import '../bookingservicescreen/bookingblock/booking_slots_bloc.dart';
import '../bookingservicescreen/bookingblock/booking_slots_event.dart';

class HistoryBody extends StatelessWidget {
  final List<BookingEntity> bookings;
  final Future<void> Function() onRefresh;
  final void Function(int) onDelete;
  final bool enableDelete;

  const HistoryBody({
    super.key,
    required this.bookings,
    required this.onRefresh,
    required this.onDelete,
    this.enableDelete = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    final displayBookings =
        bookings.where((b) => b.status != 'CANCELED').toList();

    if (displayBookings.isEmpty) {
      return const HistoryEmptyState();
    }

    Widget _buildDismissible(BookingEntity booking, Widget child) {
      if (!enableDelete) {
        return child;
      }

      return Dismissible(
        key: Key(booking.id.toString()),
        direction: DismissDirection.endToStart,
        onDismissed: (_) {
          onDelete(booking.id);
        },
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: colors.statusError,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.delete, color: colors.textOnPrimary, size: 30),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: child,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: colors.primaryBlue,
      child: ListView(
        padding: const EdgeInsets.all(20),
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children:
            displayBookings
                .map(
                  (b) => _buildDismissible(
                    b,
                    HistoryBookingCard(
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
                )
                .toList(),
      ),
    );
  }
}
