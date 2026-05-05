// lib/uikit/widgets/calendar_scroll_controller.dart
import 'package:flutter/material.dart';

class CalendarScrollController {
  final double itemWidth;
  final double separatorWidth;
  final List<DateTime> days;
  final VoidCallback onMonthChanged;

  late final ScrollController scrollController;
  DateTime focusedMonth;

  CalendarScrollController({
    required this.days,
    required this.itemWidth,
    required this.separatorWidth,
    required this.focusedMonth,
    required this.onMonthChanged,
  }) {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  double get step => itemWidth + separatorWidth;

  void _scrollListener() {
    int firstVisibleIndex = (scrollController.offset / step).round();
    if (firstVisibleIndex < days.length) {
      final currentMonth = days[firstVisibleIndex];
      if (currentMonth.month != focusedMonth.month || currentMonth.year != focusedMonth.year) {
        focusedMonth = currentMonth;
        onMonthChanged();
      }
    }
  }

  void scrollToMonth(bool next) {
    // Поиск индекса следующего/предыдущего месяца
    final targetMonth = next
        ? DateTime(focusedMonth.year, focusedMonth.month + 1)
        : DateTime(focusedMonth.year, focusedMonth.month - 1);

    final index = days.indexWhere((d) => d.year == targetMonth.year && d.month == targetMonth.month);

    if (index != -1) {
      scrollController.animateTo(
        index * step,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void dispose() => scrollController.dispose();
}
