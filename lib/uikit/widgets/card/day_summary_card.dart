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

    // Состояние "Есть записи"
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.5)),
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

          Row(
            children: [
              Expanded(
                child: StatSquareCard(
                  label: AppStrings.orders,
                  value: "${appointments.length}",
                  icon: Icons.people_outline,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: StatSquareCard(
                  label: AppStrings.serviceHours,
                  value: "${appointments.totalWorkHours()} ч.",
                  icon: Icons.timer_outlined,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: StatSquareCard(
                  label: AppStrings.start,
                  value: "${appointments.first.startTime.hour}:00",
                  icon: Icons.play_circle_outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
              color: AppColors.primaryGrey.withOpacity(0.5),
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
