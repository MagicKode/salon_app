import 'package:flutter/material.dart';

import '../../feature/core/bookingservicescreen/utils/date_helper.dart';

class DateCard extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  const DateCard({
    super.key,
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 65,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1D4D4F) : Colors.grey[100],
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateHelper.toWeekday(date),
              style: TextStyle(
                color: isSelected ? Colors.white70 : Colors.grey,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${date.day}',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
