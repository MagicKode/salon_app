import 'package:flutter/material.dart';
import 'calendar/app_calendar_section.dart';

class DateSelectionSection extends StatefulWidget {
  const DateSelectionSection({super.key});

  @override
  State<DateSelectionSection> createState() => _DateSelectionSectionState();
}

class _DateSelectionSectionState extends State<DateSelectionSection> {
  // Состояние выбранной даты храним здесь, чтобы передавать его дальше (например, в API)
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AppCalendarSection(
      selectedDay: _selectedDate,
      onDaySelected: (date) {
        setState(() {
          _selectedDate = date;
        });
        // Здесь можно добавить лог или вызов функции загрузки свободного времени для этой даты
        print("Выбранная дата: $_selectedDate");
      },
    );
  }
}