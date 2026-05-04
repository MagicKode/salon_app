import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/checkout/sections/booking_summary_card.dart';
import 'package:salon_flutter/feature/core/historyscreen/domain/booking_mock_data.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../uikit/colors/app_colors.dart';
import '../../uikit/widgets/app_button.dart';
import '../../uikit/widgets/history_booking_card.dart';
import 'booking_success_screen.dart';

class CheckoutBody extends StatelessWidget {
  const CheckoutBody({super.key});

  static const double _horizontalPadding = 24.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(_horizontalPadding, 8, _horizontalPadding, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Заголовок шторки
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.yourService,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlack,
                ),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 16,
                  color: AppColors.primaryBlue,
                ),
                label: const Text(
                  AppStrings.change,
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 16),

          // 2. Наша новая "красивая" карточка из Истории
          HistoryBookingCard(
            booking: BookingMockData.history.first,
            isDimmed: false,
          ),

          const SizedBox(height: 24), // Немного уменьшил отступ до кнопок

          // 3. Блок кнопок (сгруппированы ближе)
          AppButton(
            text: AppStrings.bookingConfirmation,
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookingSuccessScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 8), // Совсем небольшой отступ между кнопками

          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              minimumSize: const Size(double.infinity, 44), // Увеличил область нажатия
            ),
            child: const Text(
              AppStrings.cancelAndLeave,
              style: TextStyle(
                color: AppColors.primaryRed,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
