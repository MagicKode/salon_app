import 'package:flutter/material.dart';
import '../../../config/theme/custom_colors.dart';

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
    final colors = Theme.of(context).extension<CustomColors>()!;

    return AlertDialog(
      backgroundColor: colors.surfaceCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titlePadding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
      contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      actionsPadding: const EdgeInsets.fromLTRB(12, 0, 16, 16),
      title: Text(
        'Отмена записи',
        style: TextStyle(
          color: colors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'Отменить запись клиента $clientName?',
        style: TextStyle(
          color: colors.textSecondary,
          fontSize: 16,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: colors.textSecondary,
          ),
          child: const Text(
            'Нет',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          style: TextButton.styleFrom(
            foregroundColor: colors.statusError,
          ),
          child: const Text(
            'Да, отменить',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

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
