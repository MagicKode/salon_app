import 'package:flutter/material.dart';
import '../../../../../uikit/widgets/cards/date_card.dart';

class CalendarList extends StatelessWidget {
  final ScrollController controller;
  final List<DateTime> days;
  final DateTime selectedDay;
  final double separatorWidth;
  final Function(DateTime) onDaySelected;

  const CalendarList({
    super.key,
    required this.controller,
    required this.days,
    required this.selectedDay,
    required this.onDaySelected,
    this.separatorWidth = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        controller: controller,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: days.length,
        separatorBuilder: (_, __) => SizedBox(width: separatorWidth),
        itemBuilder: (context, index) {
          final day = days[index];
          return GestureDetector(
            onTap: () => onDaySelected(day),
            child: DateCard(
              date: day,
              isSelected: DateUtils.isSameDay(day, selectedDay),
              isToday: DateUtils.isSameDay(day, DateTime.now()),
            ),
          );
        },
      ),
    );
  }
}
