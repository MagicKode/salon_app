import 'package:flutter/material.dart';
import '../../../../../uikit/colors/app_colors.dart';
import '../../../feature/core/mastercalendarscreen/domain/appointment_model.dart';

class MasterAppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;

  const MasterAppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    // Форматируем время
    final String timeRange =
        "${appointment.startTime.hour}:${appointment.startTime.minute.toString().padLeft(2, '0')} — "
        "${appointment.endTime.hour}:${appointment.endTime.minute.toString().padLeft(2, '0')}";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.boxDecorationColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2))
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [

                // Иконка услуги (ножницы для мастера всегда актуальны)
                Container(
                  padding: const EdgeInsets.all(2),
                  child: const Icon(
                    Icons.content_cut,
                    color: AppColors.primaryBlue,
                    size: 20,
                  ),
                ),

                const SizedBox(width: 16),

                // Инфо о клиенте и услуге
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.serviceName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.primaryBlack,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Клиент: ${appointment.clientName}",
                        style: const TextStyle(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Нижняя панель с временем (аналог серой плашки с заметками)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.boxDecorationColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: AppColors.primaryGrey),
                const SizedBox(width: 8),
                Text(
                  timeRange,
                  style: const TextStyle(
                    color: AppColors.dateGrey,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                const Text(
                  "Детали",
                  style: TextStyle(
                    color: AppColors.primaryGrey,
                    fontSize: 12,
                  ),
                ),
                const Icon(Icons.chevron_right, size: 16, color: AppColors.primaryGrey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
