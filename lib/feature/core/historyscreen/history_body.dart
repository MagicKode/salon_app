import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/historyscreen/sections/activebooking/active_booking_section.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../uikit/colors/app_colors.dart';
import 'domain/booking_mock_data.dart';
import 'sections/historylist/history_list_section.dart';

class HistoryBody extends StatelessWidget {
  const HistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    final allBookings = BookingMockData.history;

    // 1. Обработка пустого состояния
    if (allBookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Красивая иконка календаря в серых тонах
            Icon(
              Icons.edit_calendar_outlined,
              size: 150,
              color: AppColors.primaryGrey.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.historyIsEmpty,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryGrey,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              AppStrings.hereWillBeYourBookingStory,
              style: TextStyle(fontSize: 14, color: AppColors.primaryGrey),
            ),
          ],
        ),
      );
    }

    // 2. Логика разделения (как у тебя была)
    final nearestBooking = allBookings.first;
    final otherBookings = allBookings.skip(1).toList();

    // 3. Основной контент
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        ActiveBookingSection(booking: nearestBooking),
        const SizedBox(height: 24),
        if (otherBookings.isNotEmpty)
          HistoryListSection(bookings: otherBookings),
      ],
    );
  }
}
