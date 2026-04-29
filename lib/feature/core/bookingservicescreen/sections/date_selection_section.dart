import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../uikit/widgets/date_card.dart';
import '../utils/date_helper.dart';

class DateSelectionSection extends StatefulWidget {
  const DateSelectionSection({super.key});

  @override
  State<DateSelectionSection> createState() => _DateSelectionSectionState();
}

class _DateSelectionSectionState extends State<DateSelectionSection> {
  late final List<DateTime> _days = DateHelper.generateDays(14);
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.dateSection,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          DateHelper.toMonthYear(_selectedDate),
          style: const TextStyle(color: Colors.blueGrey),
        ),
        const SizedBox(height: 12),
        _DatesListView(
          days: _days,
          selectedDate: _selectedDate,
          onSelect: (date) => setState(() => _selectedDate = date),
        ),
      ],
    );
  }
}

class _DatesListView extends StatelessWidget {
  final List<DateTime> days;
  final DateTime selectedDate;
  final Function(DateTime) onSelect;

  const _DatesListView({
    required this.days,
    required this.selectedDate,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder:
            (context, index) => DateCard(
              date: days[index],
              isSelected: DateUtils.isSameDay(days[index], selectedDate),
              onTap: () => onSelect(days[index]),
            ),
      ),
    );
  }
}
