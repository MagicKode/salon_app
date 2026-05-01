import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../../../../uikit/strings/app_strings.dart';
import '../utils/date_helper.dart';

class TimeSelectionSection extends StatefulWidget {
  const TimeSelectionSection({super.key});

  @override
  State<TimeSelectionSection> createState() => _TimeSelectionSectionState();
}

class _TimeSelectionSectionState extends State<TimeSelectionSection> {
  // Генерируем слоты с 9:00 до 20:00 каждые 30 минут
  final List<TimeOfDay> _slots = DateHelper.generateTimeSlots(
    startHour: 9,
    endHour: 20,
    intervalMinutes: 60,
  );

  TimeOfDay? _selectedTime;

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
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children:
              _slots.map((time) {
                final isSelected = _selectedTime == time;
                return TimeSlotChip(
                  time: DateHelper.formatTime(context, time),
                  isSelected: isSelected,
                  onTap: () => setState(() => _selectedTime = time),
                );
              }).toList(),
        ),
      ],
    );
  }
}

class TimeSlotChip extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotChip({
    super.key,
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : AppColors.primaryWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
          ),
        ),
        child: Text(
          time,
          style: TextStyle(
            color: isSelected ? AppColors.primaryWhite : AppColors.primaryBlack,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
