import 'package:flutter/material.dart';
import 'app_calendar_section.dart';

class DateSelectionSection extends StatefulWidget {
  final Function(DateTime date)? onDateSelected;

  const DateSelectionSection({
    super.key,
    this.onDateSelected,
  });

  @override
  State<DateSelectionSection> createState() => _DateSelectionSectionState();
}

class _DateSelectionSectionState extends State<DateSelectionSection> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AppCalendarSection(
      selectedDay: _selectedDate,
      onDaySelected: (date) {
        setState(() {
          _selectedDate = date;
        });

        // Передаём выбранную дату наверх
        widget.onDateSelected?.call(date);
      },
    );
  }
}
