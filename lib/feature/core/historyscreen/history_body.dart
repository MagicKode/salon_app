import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/historyscreen/sections/history_refresh_list_view.dart';
import '../../../uikit/widgets/emptyscreen/history_empty_screen.dart';
import '../../checkout/domain/booking_entity.dart';

class HistoryBody extends StatelessWidget {
  final List<BookingEntity> allBookings;
  final Future<void> Function() onRefresh;

  const HistoryBody({
    super.key,
    required this.allBookings,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (allBookings.isEmpty) {
      return const HistoryEmptyState();
    }

    final now = DateTime.now();

    // Активные (ещё не закончились)
    final activeBookings = allBookings
        .where((b) {
      final end = b.dateTime.add(Duration(minutes: b.durationMinutes));
      return end.isAfter(now);
    })
        .toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    // Прошедшие
    final pastBookings = allBookings
        .where((b) {
      final end = b.dateTime.add(Duration(minutes: b.durationMinutes));
      return end.isBefore(now);
    })
        .toList()
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));

    return HistoryRefreshListView(
      activeBookings: activeBookings,
      pastBookings: pastBookings,
      onRefresh: onRefresh,
    );
  }
}
