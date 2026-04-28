import 'package:flutter/material.dart';

class TimeSelectionSection extends StatelessWidget {
  const TimeSelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Демо-данные для слотов
    final List<String> timeSlots = [
      "08:00 AM", "09:00 AM", "10:00 AM",
      "11:00 AM", "01:00 PM", "02:00 PM"
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Time",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap( // Используем Wrap для автоматического переноса кнопок на новую строку
          spacing: 10,
          runSpacing: 10,
          children: timeSlots.map((time) {
            final isSelected = time == "10:00 AM"; // Заглушка выбора
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE8F4F4) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? const Color(0xFF4CA6A8) : Colors.grey.shade300,
                  width: 1.5,
                ),
              ),
              child: Text(
                time,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF4CA6A8) : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}