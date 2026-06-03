import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/historyscreen/sections/activebooking/active_booking_section.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../uikit/colors/app_colors.dart';
import '../../checkout/domain/booking_entity.dart';
import 'sections/historylist/history_list_section.dart';

class HistoryBody extends StatelessWidget {
  final List<BookingEntity> allBookings;

  const HistoryBody({super.key, required this.allBookings});

  @override
  Widget build(BuildContext context) {
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

    final now = DateTime.now();

    /// 2. Отбираем АКТИВНЫЕ записи (время завершения которых еще не прошло)
    // Сортируем их по возрастанию — чтобы самая ближайшая была сверху
    final activeBookings =
        allBookings.where((b) => b.dateTime.isAfter(now)).toList()
          ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    // 3. Отбираем ПРОШЕДШИЕ записи (которые уже в прошлом)
    // Сортируем по убыванию — чтобы самая последняя посещенная была первой в списке
    final pastBookings =
        allBookings.where((b) => b.dateTime.isBefore(now)).toList()
          ..sort((a, b) => b.dateTime.compareTo(a.dateTime));

    return RefreshIndicator(
      onRefresh: () async {
        // Логика обновления списка при пулл-ту-рефреш (прикрутим через Блок)
      },
      child: ListView(
        padding: const EdgeInsets.all(20),
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: [
          // Если есть активные брони — показываем самую ближайшую
          if (activeBookings.isNotEmpty) ...[
            ActiveBookingSection(booking: activeBookings.first),
            const SizedBox(height: 24),
          ],

          // Все остальные активные записи (если их несколько) + прошедшие улетают в историю
          if (pastBookings.isNotEmpty || activeBookings.length > 1) ...[
            // Объединяем "хвост" активных записей и прошедшие для вывода списка
            HistoryListSection(
              bookings: [...activeBookings.skip(1), ...pastBookings],
            ),
          ],
        ],
      ),
    );
  }
}
