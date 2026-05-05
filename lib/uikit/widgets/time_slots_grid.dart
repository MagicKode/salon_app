import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/widgets/time_slot_card.dart';

class TimeSlotsGrid extends StatelessWidget {
  final List<TimeOfDay> slots;
  final TimeOfDay? selectedTime;
  final Function(TimeOfDay) onTimeSelected;
  final String Function(BuildContext, TimeOfDay) formatLabel;

  const TimeSlotsGrid({
    super.key,
    required this.slots,
    required this.selectedTime,
    required this.onTimeSelected,
    required this.formatLabel,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: slots.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 колонки
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.5, // Пропорции кнопки
      ),
      itemBuilder: (context, index) {
        final time = slots[index];
        return TimeSlotCard(
          time: formatLabel(context, time),
          isSelected: selectedTime == time,
          onTap: () => onTimeSelected(time),
        );
      },
    );
  }
}
