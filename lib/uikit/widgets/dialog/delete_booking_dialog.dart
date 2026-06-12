import 'package:flutter/material.dart';
import '../../colors/app_colors.dart';

class DeleteBookingDialog extends StatelessWidget {
  final String clientName;
  final VoidCallback onConfirm;

  const DeleteBookingDialog({
    super.key,
    required this.clientName,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Отмена записи'),
      content: Text('Отменить запись клиента $clientName?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Нет'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: const Text(
            'Да, отменить',
            style: TextStyle(color: AppColors.primaryRed),
          ),
        ),
      ],
    );
  }

  /// Статический метод для быстрого вызова
  static Future<void> show(BuildContext context, {
    required String clientName,
    required VoidCallback onConfirm,
  }) {
    return showDialog(
      context: context,
      builder: (_) => DeleteBookingDialog(
        clientName: clientName,
        onConfirm: onConfirm,
      ),
    );
  }
}
