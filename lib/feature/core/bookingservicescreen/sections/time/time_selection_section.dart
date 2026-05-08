import 'package:flutter/material.dart';

import '../../../../../uikit/strings/app_strings.dart';
import '../../../../../uikit/widgets/time/time_slots_grid.dart';
import '../../utils/date_helper.dart';

class TimeSelectionSection extends StatefulWidget {
  final Function(TimeOfDay?) onTimeChanged;
  final int requiredSlots;

  const TimeSelectionSection({
    super.key,
    required this.onTimeChanged,
    required this.requiredSlots,
  });

  @override
  State<TimeSelectionSection> createState() => _TimeSelectionSectionState();
}

class _TimeSelectionSectionState extends State<TimeSelectionSection> {
  late final List<TimeOfDay> _slots;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _slots = DateHelper.generateTimeSlots(
      startHour: 9,
      endHour: 20,
      intervalMinutes: 60,
    );
  }

  void _handleTimeTap(TimeOfDay startTime) {
    final startIndex = _slots.indexOf(startTime);

    // Проверка: хватает ли времени до конца рабочего дня?
    if (startIndex + widget.requiredSlots > _slots.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.notEnoughTimeForService)),
      );
      return;
    }

    setState(() => _selectedTime = startTime);
    widget.onTimeChanged(startTime);
  }

  @override
  Widget build(BuildContext context) {
    // Вычисляем список всех выделенных слотов для подсветки
    List<TimeOfDay> selectedRange = [];
    if (_selectedTime != null) {
      int startIdx = _slots.indexOf(_selectedTime!);
      // Собираем диапазон выбранных слотов
      for (int i = 0; i < widget.requiredSlots; i++) {
        if (startIdx + i < _slots.length) {
          selectedRange.add(_slots[startIdx + i]);
        }
      }
    }
    // 2. Возврат интерфейса (UI) - всегда в конце метода
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.timeSection,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TimeSlotsGrid(
          slots: _slots,
          // Передаем основной выбранный слот
          selectedTime: _selectedTime,
          selectedSlots: selectedRange,
          onTimeSelected: _handleTimeTap,
          formatLabel: (ctx, time) => DateHelper.formatTime(ctx, time),
        ),
      ],
    );
  }
}
