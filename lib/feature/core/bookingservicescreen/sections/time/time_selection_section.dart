import 'package:flutter/material.dart';

import '../../../../../uikit/strings/app_strings.dart';
import '../../../../../uikit/widgets/time/time_slots_grid.dart';
import '../../utils/date_helper.dart';

class TimeSelectionSection extends StatefulWidget {
  final Function(TimeOfDay?) onTimeChanged;

  const TimeSelectionSection({super.key, required this.onTimeChanged});

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

  void _handleTimeTap(TimeOfDay time) {
    setState(() => _selectedTime = time);
    widget.onTimeChanged(time);
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
          slots: _slots,
          selectedTime: _selectedTime,
          onTimeSelected: _handleTimeTap,
          formatLabel: (ctx, time) => DateHelper.formatTime(ctx, time),
        ),
      ],
    );
  }
}
