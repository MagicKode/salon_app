import 'package:flutter/material.dart';

import '../../../../../uikit/strings/app_strings.dart';
import './calendar_scroll_controller.dart';
import 'calendar_header.dart';
import 'calendar_list.dart';

class AppCalendarSection extends StatefulWidget {
  final DateTime selectedDay;
  final Function(DateTime) onDaySelected;

  const AppCalendarSection({
    super.key,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  State<AppCalendarSection> createState() => _AppCalendarSectionState();
}

class _AppCalendarSectionState extends State<AppCalendarSection> {
  static const double _cardWidth = 60.0;
  static const double _separatorWidth = 12.0;

  late final List<DateTime> _days;
  late final CalendarScrollController _calendarLogic;

  @override
  void initState() {
    super.initState();
    _days = List.generate(
      365,
      (index) => DateTime.now().add(Duration(days: index)),
    );

    _calendarLogic = CalendarScrollController(
      days: _days,
      itemWidth: _cardWidth,
      separatorWidth: _separatorWidth,
      focusedMonth: DateTime.now(),
      onMonthChanged: () => setState(() {}),
    );
  }

  @override
  void dispose() {
    _calendarLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.dateSection,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        CalendarHeader(
          focusedMonth: _calendarLogic.focusedMonth,
          onLeftChevronTap: () => _calendarLogic.scrollToMonth(false),
          onRightChevronTap: () => _calendarLogic.scrollToMonth(true),
        ),
        const SizedBox(height: 12),
        CalendarList(
          controller: _calendarLogic.scrollController,
          days: _days,
          selectedDay: widget.selectedDay,
          onDaySelected: widget.onDaySelected,
          separatorWidth: _separatorWidth,
        ),
      ],
    );
  }
}
