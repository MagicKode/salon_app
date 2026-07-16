import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов
import '../../uikit/widgets/button/app_button.dart';
import '../auth/authblock/bloc/auth_block.dart';
import '../auth/authblock/bloc/auth_state.dart';
import 'booking_success_screen.dart';
import 'domain/booking_entity.dart';
import 'domain/repository/booking_repository.dart';
import 'sections/booking_summary_card.dart';
import 'sections/cash_payment_info.dart';

class CheckoutBody extends StatelessWidget {
  final BookingEntity booking;

  const CheckoutBody({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем кастомные цвета темы
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.yourService,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                ),
              ),
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.edit_outlined, size: 18, color: colors.primaryBlue),
                label: Text(
                  AppStrings.change,
                  style: TextStyle(color: colors.primaryBlue),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          BookingSummaryCard(booking: booking),

          const SizedBox(height: 12),

          const CashPaymentInfo(),

          const SizedBox(height: 12),

          AppButton(
            text: AppStrings.bookingConfirmation,
            onPressed: () => _onConfirm(context),
          ),
          const SizedBox(height: 12),

          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppStrings.cancelAndLeave,
              style: TextStyle(
                color: colors.statusError,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onConfirm(BuildContext context) async {
    final colors = Theme.of(context).extension<CustomColors>()!;

    print("=== [DEBUG] Нажата кнопка подтверждения бронирования ===");

    _showLoadingDialog(context, colors);
    final bookingRepository = RepositoryProvider.of<BookingRepository>(context);

    final authState = context.read<AuthBloc>().state;
    String? jwtToken;

    if (authState is AuthSuccess) {
      jwtToken = authState.user.token;
      print("=== [DEBUG] Токен успешно найден ===");
    } else {
      print("=== [DEBUG] Ошибка: Текущий стейт AuthBloc НЕ AuthSuccess! Стейт: $authState ===");
    }

    if (jwtToken == null) {
      if (context.mounted) Navigator.pop(context);
      _showErrorSnackBar(context, "Ошибка авторизации. Пожалуйста, войдите снова.");
      return;
    }

    try {
      print("=== [DEBUG] Отправляем запрос на сервер... ===");
      final bool isSuccess = await bookingRepository.sendBooking(booking);
      print("=== [DEBUG] Ответ от сервера успешный! Результат: $isSuccess ===");

      if (context.mounted) Navigator.pop(context);

      if (isSuccess && context.mounted) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookingSuccessScreen(
              bookingId: '${booking.id}',
            ),
          ),
        );
      }
    } catch (error) {
      print("=== [DEBUG] Поймали ошибку при отправке: $error ===");
      if (context.mounted) Navigator.pop(context);
      _showErrorSnackBar(context, error.toString().replaceAll("Exception: ", ""));
    }
  }

  void _showLoadingDialog(BuildContext context, CustomColors colors) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: colors.primaryBlue,
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: colors.textOnPrimary),
        ),
        backgroundColor: colors.statusError,
      ),
    );
  }
}
