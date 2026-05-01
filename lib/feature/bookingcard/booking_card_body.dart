import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/bookingcard/bookinghistory/domain/booking_mock_data.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../uikit/colors/app_colors.dart';
import '../../uikit/widgets/app_button.dart';
import 'bookinghistory/feature/widgets/booking_card.dart';
import 'feature/checkout/sections/booking_success_screen.dart';

class BookingCardBody extends StatelessWidget {
  const BookingCardBody({super.key});

  static const double _horizontalPadding = 24.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(_horizontalPadding, 8, _horizontalPadding, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Заголовок шторки
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

          BookingCard(booking: BookingMockData.history.first),

          const SizedBox(height: 32),

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

          const SizedBox(height: 12),

          // Отмена (просто закрывает шторку)
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              AppStrings.cancelAndLeave,
              style: TextStyle(
                color: AppColors.primaryRed,
                fontWeight: FontWeight.w500,
                fontSize: 15
              ),
            ),
          ),
        ],
      ),
    );
  }
}
