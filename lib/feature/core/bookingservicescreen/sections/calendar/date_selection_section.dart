import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bookingblock/booking_slots_bloc.dart';
import '../../bookingblock/booking_slots_event.dart';
import 'app_calendar_section.dart';

class DateSelectionSection extends StatefulWidget {
  final String masterName;
  final Function(DateTime date)? onDateSelected;

  const DateSelectionSection({
    super.key,
    required this.masterName,
    this.onDateSelected,

  });

  @override
  State<DateSelectionSection> createState() => _DateSelectionSectionState();
}

class _DateSelectionSectionState extends State<DateSelectionSection> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Загружаем слоты на сегодня сразу при инициализации виджета
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSlotsForDate(_selectedDate);
    });
  }

  void _loadSlotsForDate(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);

    context.read<BookingSlotsBloc>().add(
      LoadBookingSlotsEvent(
        masterName: widget.masterName,
        date: normalizedDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCalendarSection(
      selectedDay: _selectedDate,
      onDaySelected: (date) {
        setState(() {
          _selectedDate = date;
        });

        _loadSlotsForDate(date);

        // Передаём выбранную дату наверх
        widget.onDateSelected?.call(date);
      },
    );
  }
}
