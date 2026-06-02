import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../uikit/colors/app_colors.dart';
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

  CheckoutBody({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.yourService,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.edit_outlined, size: 18),
                label: const Text(AppStrings.change),
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
              style: TextStyle(color: AppColors.primaryRed, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  /// Чистая и лаконичная обработка нажатия кнопки подтверждения
  Future<void> _onConfirm(BuildContext context) async {
    print("=== [DEBUG] Нажата кнопка подтверждения бронирования ===");

    // 1. Показываем лоадер загрузки
    _showLoadingDialog(context);
    final bookingRepository = RepositoryProvider.of<BookingRepository>(context);

    // 2. Получаем JWT токен из стейта авторизации
    final authState = context.read<AuthBloc>().state;
    String? jwtToken;

    if (authState is AuthSuccess) {
      jwtToken = authState.user.token;
      print("=== [DEBUG] Токен успешно найден ===");
    } else {
      print("=== [DEBUG] Ошибка: Текущий стейт AuthBloc НЕ AuthSuccess! Стейт: $authState ===");
    }

    if (jwtToken == null) {
      if (context.mounted) Navigator.pop(context); // FIX: Закрываем лоадер, чтобы экран не завис
      _showErrorSnackBar(context, "Ошибка авторизации. Пожалуйста, войдите снова.");
      return;
    }

    try {
      print("=== [DEBUG] Отправляем запрос на сервер... ===");
      // 3. Вызываем изолированный метод отправки из репозитория
      final bool isSuccess = await bookingRepository.sendBooking(booking, jwtToken);
      print("=== [DEBUG] Ответ от сервера успешный! Результат: $isSuccess ===");

      if (context.mounted) Navigator.pop(context); // Скрываем лоадер

      if (isSuccess && context.mounted) {
        Navigator.pop(context); // Успех — убираем шторку чекаута и открываем экран успеха
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BookingSuccessScreen()),
        );
      }
    } catch (error) {
      print("=== [DEBUG] Поймали ошибку при отправке: $error ===");
      if (context.mounted) Navigator.pop(context); // Скрываем лоадер при ошибке
      _showErrorSnackBar(context, error.toString().replaceAll("Exception: ", ""));
    }
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: AppColors.primaryBlue),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.primaryRed,
      ),
    );
  }
}
