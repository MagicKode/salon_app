import 'package:flutter/material.dart';

class AppointmentStatusChip extends StatelessWidget {
  final String? status;

  const AppointmentStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg, text;
    String label;
    switch (status?.toUpperCase()) {
      case 'CONFIRMED':
        bg = Colors.green;
        text = Colors.white;
        label = 'Подтверждено';
        break;
      case 'PENDING':
        bg = Colors.orange;
        text = Colors.white;
        label = 'Ожидает';
        break;
      case 'CANCELED':
        bg = Colors.red;
        text = Colors.white;
        label = 'Отменено';
        break;
      default:
        bg = Colors.grey;
        text = Colors.white;
        label = 'Неизвестно';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
    );
  }
}
