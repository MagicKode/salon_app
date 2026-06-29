import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/domain/time_slot_model.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../../../../../uikit/strings/app_strings.dart';
import '../../../../../uikit/widgets/time/time_slots_grid.dart';
import '../../bookingblock/booking_slots_bloc.dart';
import '../../bookingblock/booking_slots_state.dart';

class TimeSelectionSection extends StatefulWidget {
  final Function(String?) onTimeChanged;
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
  List<TimeSlotModel> _selectedRange = [];
  String? _selectedTime;

  void _handleTimeTap(String startTime, List<TimeSlotModel> availableSlots) {
    final startIndex = availableSlots.indexWhere(
      (slot) => slot.time == startTime,
    );

    if (startIndex == -1) return;

    // Проверка: хватает ли времени до конца рабочего дня?
    if (startIndex + widget.requiredSlots > availableSlots.length) {
      _showErrorSnackBar(AppStrings.notEnoughTimeForService);
      return;
    }

    // 2. Проверка: свободны ли все последующие слоты подряд для длинной услуги?
    final List<TimeSlotModel> temporaryRange = [];
    for (int i = 0; i < widget.requiredSlots; i++) {
      final nextSlot = availableSlots[startIndex + i];

      if (!nextSlot.isAvailable) {
        _showErrorSnackBar(
          "Недостаточно свободного времени подряд для этой услуги!",
        );
        return;
      }
      temporaryRange.add(nextSlot);
    }

    // 3. Если всё ок — сохраняем выбор в стейт виджета для подсветки UI
    setState(() {
      _selectedTime = startTime;
      _selectedRange = temporaryRange;
    });

    // 4. Передаем наверх родителю строку времени
    widget.onTimeChanged(startTime);
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.primaryRed),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.timeSection,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TimeSlotsGrid(
          selectedTime: _selectedTime,
          selectedSlots: _selectedRange,
          onTimeSelected: (String timeLabel) {
            // Читаем текущее состояние Блока прямо в момент клика для валидации
            final state = context.read<BookingSlotsBloc>().state;
            if (state is BookingSlotsSuccess) {
              _handleTimeTap(timeLabel, state.slots);
            }
          },
        ),
      ],
    );
  }
}
