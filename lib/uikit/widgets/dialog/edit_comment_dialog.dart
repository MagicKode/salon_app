import 'package:flutter/material.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../../feature/checkout/domain/repository/booking_repository.dart';

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
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Комментарий к записи',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      content:
          _isLoading
              ? const SizedBox(
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryBlue,
                  ),
                ),
              )
              : TextField(
                controller: _commentController,
                maxLines: 3,
                maxLength: 200,
                decoration: InputDecoration(
                  hintText: 'Например: опоздаю на 5 минут / нужен дизайн...',
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.7),
                    fontSize: 14,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                      color: AppColors.primaryBlue,
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
                  child: const Text(
                    'Отмена',
                    style: TextStyle(color: AppColors.primaryGrey),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    final newComment = _commentController.text.trim();

                    setState(() => _isLoading = true);

                    // ВЫЗЫВАЕМ РЕАЛЬНЫЙ МЕТОД РЕПОЗИТОРИЯ
                    final success = await widget.bookingRepository
                        .updateBookingComment(widget.bookingId, newComment);

                    if (mounted) {
                      setState(() => _isLoading = false);
                      if (success) {
                        Navigator.pop(context, newComment);
                        widget.onUpdateSuccess
                            ?.call(); // Вызываем onRefresh на экране истории
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Не удалось сохранить изменения'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Сохранить',
                    style: TextStyle(color: AppColors.primaryWhite),
                  ),
                ),
              ],
    );
  }
}
