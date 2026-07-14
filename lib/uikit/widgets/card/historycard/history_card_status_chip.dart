import 'package:flutter/material.dart';

class HistoryCardStatusChip extends StatelessWidget {
  final String status;
  final bool isPast;

  const HistoryCardStatusChip({
    super.key,
    required this.status,
    required this.isPast,
  });

  @override
  Widget build(BuildContext context) {
    String label;
    Color bg;
    switch (status.toUpperCase()) {
      case 'CONFIRMED':
        label = isPast ? 'Завершено' : 'Подтверждено';
        bg = Colors.green;
        break;
      case 'CANCELED':
        label = 'Отменено';
        bg = Colors.red;
        break;
      case 'PENDING':
        label = 'Ожидает';
        bg = Colors.orange;
        break;
      default:
        label = 'Неизвестно';
        bg = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(
        label,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );
  }
}
