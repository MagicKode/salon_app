import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/navigation/main_navigation_screen.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import 'package:salon_flutter/uikit/widgets/button/app_button.dart';
import '../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов

import 'domain/repository/booking_repository.dart';

class BookingSuccessScreen extends StatelessWidget {
  final String bookingId;

  const BookingSuccessScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем кастомные цвета темы
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      backgroundColor: colors.backgroundPrimary,
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
                decoration: BoxDecoration(
                  color: colors.surfaceCard,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: colors.statusSuccess,
                  size: 80,
                ),
              ),
              const SizedBox(height: 32),

              const Text(
                AppStrings.bookedSuccessful,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.serviceWelcomeMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: colors.textSecondary,
                ),
              ),
              const Spacer(),

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

  void _showCancelConfirmation(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          AppStrings.cancellingBooking,
          style: TextStyle(color: colors.textPrimary),
        ),
        content: Text(
          AppStrings.confirmationOfCancellingBooking,
          style: TextStyle(color: colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              AppStrings.back,
              style: TextStyle(color: colors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);

              final success = await context
                  .read<BookingRepository>()
                  .cancelBooking(bookingId);

              if (success) {
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainNavigationScreen(),
                    ),
                        (route) => false,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppStrings.bookingIsCanceled,
                        style: TextStyle(color: colors.textOnPrimary),
                      ),
                      backgroundColor: colors.statusSuccess,
                    ),
                  );
                }
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppStrings.errorInDeleteService,
                        style: TextStyle(color: colors.textOnPrimary),
                      ),
                      backgroundColor: colors.statusError,
                    ),
                  );
                }
              }
            },
            child: Text(
              AppStrings.confirmCancelling,
              style: TextStyle(color: colors.statusError),
            ),
          ),
        ],
      ),
    );
  }
}
