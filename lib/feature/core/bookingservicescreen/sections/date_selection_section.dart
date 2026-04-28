import 'package:flutter/material.dart';

class DateSelectionSection extends StatelessWidget {
  const DateSelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Date",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        // Переключатель месяца
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, color: Color(0xFF4CA6A8)),
              onPressed: () {},
            ),
            const Text(
              "March, 2021",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right, color: Color(0xFF4CA6A8)),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Горизонтальный список дней
        SizedBox(
          height: 90,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildDayCard("Wed", "9", false),
              _buildDayCard("Thu", "10", true), // Выбранный день
              _buildDayCard("Fri", "11", false),
              _buildDayCard("Sat", "12", false),
              _buildDayCard("Sun", "13", false),
              _buildDayCard("Mon", "14", false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDayCard(String day, String number, bool isSelected) {
    return Container(
      width: 65,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1D4D4F) : Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: isSelected
            ? [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 4))]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              color: isSelected ? Colors.white70 : Colors.grey,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            number,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}