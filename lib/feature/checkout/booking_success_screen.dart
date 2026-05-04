import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/navigation/main_navigation_screen.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import 'package:salon_flutter/uikit/widgets/app_button.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: AppColors.primaryWhite,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primaryGreen,
                  size: 80,
                ),
              ),
              const SizedBox(height: 32),

              // Текст статуса
              const Text(
                AppStrings.bookedSuccessful,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlack,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                AppStrings.serviceWelcomeMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColors.primaryGrey),
              ),
              const Spacer(),

              // 2. Кнопка «На главную»
              AppButton(
                text: AppStrings.toHomePage,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainNavigationScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 16),

              // 3. Кнопка «Отменить бронирование»
              AppButton(
                text: AppStrings.cancelBooking,
                onPressed: () => _showCancelConfirmation(context),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // Метод для подтверждения отмены
  void _showCancelConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(AppStrings.cancellingBooking),
            content: const Text(AppStrings.confirmationOfCancellingBooking),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  AppStrings.back,
                  style: TextStyle(color: AppColors.primaryGrey),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Возвращаем на главную после отмены
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainNavigationScreen(),
                    ),
                    (route) => false,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(AppStrings.bookingIsCanceled)),
                  );
                },
                child: const Text(
                  AppStrings.confirmCancelling,
                  style: TextStyle(color: AppColors.primaryRed),
                ),
              ),
            ],
          ),
    );
  }
}
