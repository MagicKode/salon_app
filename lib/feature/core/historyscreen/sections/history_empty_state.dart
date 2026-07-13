import 'package:flutter/material.dart';

class HistoryEmptyState extends StatelessWidget {
  const HistoryEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'У вас пока нет записей',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text(
            'Запишитесь на услугу, чтобы она появилась здесь',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}
