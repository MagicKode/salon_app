import 'package:flutter/material.dart';

import '../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов
import '../../../feature/checkout/domain/repository/booking_repository.dart';
import '../../colors/app_colors.dart';

class EditCommentDialog extends StatefulWidget {
  final String bookingId;
  final String initialComment;
  final BookingRepository bookingRepository;
  final VoidCallback? onUpdateSuccess;

  const EditCommentDialog({
    super.key,
    required this.bookingId,
    required this.initialComment,
    required this.bookingRepository,
    this.onUpdateSuccess,
  });

  @override
  State<EditCommentDialog> createState() => _EditCommentDialogState();
}

class _EditCommentDialogState extends State<EditCommentDialog> {
  late final TextEditingController _commentController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController(text: widget.initialComment);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return AlertDialog(
      backgroundColor: colors.backgroundPrimary,
      // ✅ динамический фон
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        'Комментарий к записи',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: colors.textPrimary, // ✅ динамический цвет заголовка
        ),
      ),
      content:
          _isLoading
              ? const SizedBox(
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(
                    color:
                        AppColors
                            .primaryBlue, // оставляем или заменим на colors.primaryBlue
                  ),
                ),
              )
              : TextField(
                controller: _commentController,
                maxLines: 3,
                maxLength: 200,
                style: TextStyle(color: colors.textPrimary),
                // ✅ динамический текст
                decoration: InputDecoration(
                  hintText: 'Например: опоздаю на 5 минут / нужен дизайн...',
                  hintStyle: TextStyle(
                    color: colors.textHint, // ✅ динамическая подсказка
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: colors.surfaceInput,
                  // ✅ динамический фон поля
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                      color: colors.borderLight,
                    ), // ✅ динамическая граница
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                      color: colors.borderLight,
                    ), // ✅ динамическая граница
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                      color: colors.primaryBlue, // ✅ динамический синий
                      width: 1.5,
                    ),
                  ),
                ),
              ),
      actions:
          _isLoading
              ? null
              : [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Отмена',
                    style: TextStyle(
                      color: colors.textSecondary,
                    ), // ✅ динамический серый
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primaryBlue, // ✅ динамический синий
                    foregroundColor:
                        colors.textOnPrimary, // ✅ динамический белый
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    final newComment = _commentController.text.trim();

                    setState(() => _isLoading = true);

                    final success = await widget.bookingRepository
                        .updateBookingComment(widget.bookingId, newComment);

                    if (mounted) {
                      setState(() => _isLoading = false);
                      if (success) {
                        Navigator.pop(context, newComment);
                        widget.onUpdateSuccess?.call();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Не удалось сохранить изменения',
                              style: TextStyle(color: colors.textOnPrimary),
                            ),
                            backgroundColor: colors.statusError,
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Сохранить'),
                ),
              ],
    );
  }
}
