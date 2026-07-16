import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../config/theme/custom_colors.dart';
import '../button/app_button.dart';

class CreateNotificationBottomSheet extends StatefulWidget {
  final VoidCallback? onSuccess;

  const CreateNotificationBottomSheet({super.key, this.onSuccess});

  @override
  State<CreateNotificationBottomSheet> createState() =>
      _CreateNotificationBottomSheetState();
}

class _CreateNotificationBottomSheetState
    extends State<CreateNotificationBottomSheet> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  bool _isSending = false;

  Future<void> _sendNotification() async {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();

    if (title.isEmpty || body.isEmpty) {
      _showSnackBar('Заполните все поля', isError: true);
      return;
    }

    // ✅ Проверяем интернет
    final connectivityResult = await Connectivity().checkConnectivity();
    final hasInternet = connectivityResult != ConnectivityResult.none;

    if (!hasInternet) {
      _showNoInternetDialog();
      return;
    }

    setState(() => _isSending = true);

    try {
      // Здесь ваша логика отправки
      final success = await _sendToServer(title, body);

      if (success) {
        Navigator.pop(context);
        _showSnackBar(AppStrings.notificationSuccessfullySent, isError: false);
        widget.onSuccess?.call();
      } else {
        _showSnackBar('Ошибка при отправке уведомления', isError: true);
      }
    } catch (e) {
      _showSnackBar('Ошибка: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  // 🔧 Замените на ваш реальный метод отправки
  Future<bool> _sendToServer(String title, String body) async {
    // Ваша логика отправки
    // Например: await notificationRepository.broadcastToAll(title, body, phone);
    return true;
  }

  void _showNoInternetDialog() {
    final colors = Theme.of(context).extension<CustomColors>()!;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: colors.backgroundPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              'Нет интернета',
              style: TextStyle(color: colors.textPrimary, fontSize: 18),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.wifi_off_rounded,
                  size: 48,
                  color: colors.statusError,
                ),
                const SizedBox(height: 12),
                Text(
                  'Проверьте подключение к интернету и попробуйте снова',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colors.textSecondary, fontSize: 14),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Закрыть',
                  style: TextStyle(color: colors.textSecondary),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _sendNotification();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primaryBlue,
                  foregroundColor: colors.textOnPrimary,
                ),
                child: const Text('Повторить'),
              ),
            ],
          ),
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: colors.textOnPrimary)),
        backgroundColor: isError ? colors.statusError : colors.statusSuccess,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Container(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceCard,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Divider(thickness: 4, indent: 140, endIndent: 140),
          ),
          const SizedBox(height: 20),

          Text(
            AppStrings.extraNotifications,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _titleController,
            style: TextStyle(color: colors.textPrimary),
            decoration: InputDecoration(
              hintText: AppStrings.themeOfNotification,
              hintStyle: TextStyle(
                color: colors.textHint,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colors.borderLight),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colors.borderLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colors.primaryBlue, width: 2),
              ),
              filled: true,
              fillColor: colors.surfaceInput,
            ),
          ),
          const SizedBox(height: 12),

          TextField(
            controller: _bodyController,
            maxLines: 3,
            style: TextStyle(color: colors.textPrimary),
            decoration: InputDecoration(
              hintText: AppStrings.themeOfNotificationForClient,
              hintStyle: TextStyle(
                color: colors.textHint,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colors.borderLight),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colors.borderLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colors.primaryBlue, width: 2),
              ),
              filled: true,
              fillColor: colors.surfaceInput,
            ),
          ),
          const SizedBox(height: 20),

          AppButton(
            text:
                _isSending
                    ? 'Отправка...'
                    : AppStrings.sendNotificationToAllClients,
            onPressed: _sendNotification,
            isLoading: _isSending,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
}
