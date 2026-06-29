import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/widgets/card/stat_square_card.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../../feature/core/mastercalendarscreen/domain/appointment_model.dart';
import '../../strings/app_strings.dart';

class DaySummaryCard extends StatelessWidget {
  final List<AppointmentModel> appointments;
  final DateTime selectedDate;

  const DaySummaryCard({
    super.key,
    required this.appointments,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    // Состояние "Нет записей"
    if (appointments.isEmpty) return _buildEmptyState();

    // ✅ Сортируем по времени
    final sorted = List<AppointmentModel>.from(appointments)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    // Состояние "Есть записи"
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.daySchedule,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.primaryBlack,
            ),
          ),

          const SizedBox(height: 16),

          // Сетка 2х2
          GridView.count(
            crossAxisCount: 2,           // 2 колонки
            shrinkWrap: true,            // Сетка занимает только нужное место
            physics: const NeverScrollableScrollPhysics(), // Отключаем внутренний скролл
            crossAxisSpacing: 10,        // Отступы по горизонтали
            mainAxisSpacing: 10,         // Отступы по вертикали
            childAspectRatio: 2.1,       // Баланс ширины и высоты карточек
            children: [
              StatSquareCard(
                label: AppStrings.orders,
                value: "${appointments.length}",
                icon: Icons.people_outline,
              ),
              StatSquareCard(
                label: AppStrings.serviceHours,
                value: "${_calculateTotalHours(appointments)} ч.",
                icon: Icons.timer_outlined,
              ),
              StatSquareCard(
                label: AppStrings.firstClient,
                value: "${appointments.first.startTime.hour}:00",
                icon: Icons.play_circle_outline,
              ),
              StatSquareCard(
                label: AppStrings.lastClient,
                // БЕРЕМ ПОСЛЕДНЕГО: appointments.last
                value: "${appointments.last.startTime.hour}:00",
                icon: Icons.stop_circle_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ✅ Вычисляем общее количество часов
  int _calculateTotalHours(List<AppointmentModel> apps) {
    final totalMinutes = apps.fold<int>(
      0,
          (sum, a) => sum + a.endTime.difference(a.startTime).inMinutes,
    );
    return (totalMinutes / 60).round();
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.local_cafe,
              size: 64,
              color: AppColors.primaryGrey.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 20),
            const Text(
              AppStrings.noClientsForThisDay,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryGrey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
