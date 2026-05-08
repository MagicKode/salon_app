import 'package:flutter/material.dart';
import '../../colors/app_colors.dart';

class TimeSlotsGrid extends StatelessWidget {
  final List<TimeOfDay> slots;
  final TimeOfDay? selectedTime;
  final List<TimeOfDay> selectedSlots;
  final ValueChanged<TimeOfDay> onTimeSelected;
  final String Function(BuildContext, TimeOfDay) formatLabel;

  const TimeSlotsGrid({
    super.key,
    required this.slots,
    this.selectedTime,
    this.selectedSlots = const [],
    required this.onTimeSelected,
    required this.formatLabel,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.5,
      ),
      itemCount: slots.length,
      itemBuilder: (context, index) {
        final time = slots[index];
        final isHighlighted = selectedSlots.contains(time);

        return _TimeSlotTile(
          label: formatLabel(context, time),
          isHighlighted: isHighlighted,
          onTap: () => onTimeSelected(time),
        );
      },
    );
  }
}

/// Приватный виджет для отрисовки одной ячейки (SRP)
class _TimeSlotTile extends StatelessWidget {
  final String label;
  final bool isHighlighted;
  final VoidCallback onTap;

  const _TimeSlotTile({
    required this.label,
    required this.isHighlighted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isHighlighted
        ? AppColors.primaryBlue
        : AppColors.primaryBackgroundColor;

    final textColor = isHighlighted
        ? AppColors.primaryWhite
        : AppColors.primaryBlack;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: isHighlighted
              ? null
              : Border.all(color: AppColors.primaryBlackShadow),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
