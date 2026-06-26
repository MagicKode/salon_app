import 'package:flutter/material.dart';

import '../../strings/app_strings.dart';
import '../../widgets/button/app_button.dart';

class BroadcastDialog extends StatefulWidget {
  final Future<void> Function(String title, String body) onSend;

  const BroadcastDialog({super.key, required this.onSend});

  @override
  State<BroadcastDialog> createState() => _BroadcastDialogState();
}

class _BroadcastDialogState extends State<BroadcastDialog> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  bool _isLoading = false;
  bool _titleError = false;
  bool _bodyError = false;

  Future<void> _send() async {
    // Сбрасываем ошибки перед проверкой
    setState(() {
      _titleError = _titleController.text.trim().isEmpty;
      _bodyError = _bodyController.text.trim().isEmpty;
    });

    // Если хоть одно поле пустое – останавливаемся
    if (_titleError || _bodyError) return;

    setState(() => _isLoading = true);
    try {
      await widget.onSend(
        _titleController.text.trim(),
        _bodyController.text.trim(),
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.messageSent)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Ошибка: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      title: const Text(
        AppStrings.clientsMessaging,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Поле заголовка
            TextField(
              controller: _titleController,
              onChanged: (_) => setState(() => _titleError = false),
              decoration: InputDecoration(
                hintText: AppStrings.messageTitle,
                errorText: _titleError ? AppStrings.errorEmptyField : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Обычный TextField для сообщения (без AppTextField)
            TextField(
              controller: _bodyController,
              onChanged: (_) => setState(() => _bodyError = false),
              minLines: 5,
              maxLines: null,
              decoration: InputDecoration(
                hintText: AppStrings.messageText,
                errorText: _bodyError ? AppStrings.errorEmptyField : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppStrings.cancel),
        ),
        const SizedBox(width: 8),

        AppButton(
          text: AppStrings.sendMessage,
          onPressed: _send,
          isLoading: _isLoading,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
}
