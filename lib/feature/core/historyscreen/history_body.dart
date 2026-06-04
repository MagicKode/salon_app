import 'package:flutter/material.dart';

import '../../../uikit/widgets/emptyscreen/history_empty_screen.dart';
import '../../../uikit/widgets/indicator/refresh_indicator.dart';
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
    // 1. Обработка пустого состояния
    if (allBookings.isEmpty) {
      return const HistoryEmptyState();
    }

    final now = DateTime.now();

    /// 2. Отбираем АКТИВНЫЕ записи (время завершения которых еще не прошло)
    // Активные - все, которые еще не прошли
    final activeBookings =
        allBookings.where((b) {
            final endTime = b.dateTime.add(
              Duration(minutes: b.durationMinutes),
            );
            return endTime.isAfter(now);
          }).toList()
          ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    // 3. Отбираем ПРОШЕДШИЕ записи (которые уже в прошлом)
    // Сортируем по убыванию — чтобы самая последняя посещенная была первой в списке
    final pastBookings =
        allBookings.where((b) {
            final endTime = b.dateTime.add(
              Duration(minutes: b.durationMinutes),
            );
            return endTime.isBefore(now);
          }).toList()
          ..sort((a, b) => b.dateTime.compareTo(a.dateTime));

    return HistoryRefreshListView(
      activeBookings: activeBookings,
      pastBookings: pastBookings,
      onRefresh: onRefresh,
    );
  }
}
