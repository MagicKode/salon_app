import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salon_flutter/feature/core/mastercalendarscreen/domain/appointment_model.dart';
import 'package:salon_flutter/feature/core/masterschedulescreen/domain/day_availability_model.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../../../../feature/core/mastercalendarscreen/master_calendar_screen.dart';
import 'day_off_widget.dart';
import 'empty_day_widget.dart';

class DaySummaryCard extends StatelessWidget {
  final List<AppointmentModel> appointments;
  final DateTime selectedDate;
  final Map<DateTime, DayStatus> availability;
  final VoidCallback onRefresh;

  const DaySummaryCard({
    super.key,
    required this.appointments,
    required this.selectedDate,
    required this.availability,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final status = availability[selectedDate];
    if (status == DayStatus.dayOff) {
      return const DayOffWidget();
    }
    if (appointments.isEmpty) {
      return const EmptyDayWidget();
    }
    return _buildAppointmentsList(context);
  }

  Widget _buildAppointmentsList(BuildContext context) {
    final sorted = List<AppointmentModel>.from(appointments)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    // ✅ Теперь это обычный ListView без shrinkWrap
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: sorted.length,
      itemBuilder: (context, index) {
        final appointment = sorted[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _buildCompactCard(context, appointment),
        );
      },
    );
  }

  Widget _buildCompactCard(BuildContext context, AppointmentModel appointment) {
    final now = DateTime.now();
    final isPast = appointment.endTime.isBefore(now);
    final isCurrent =
        appointment.startTime.isBefore(now) && appointment.endTime.isAfter(now);
    final isFuture = appointment.startTime.isAfter(now);
    final isCanceled = appointment.status?.toUpperCase() == 'CANCELED';

    Color statusColor;
    if (isCanceled) {
      statusColor = Colors.red.shade500;
    } else if (isPast) {
    statusColor = Colors.grey.shade400;
    } else if (isCurrent) {
      statusColor = Colors.green.shade500;
    } else if (isFuture) {
      statusColor = Colors.blue.shade500;
    } else {
      statusColor = Colors.grey.shade300;
    }

    final timeStr = DateFormat('HH:mm', 'ru').format(appointment.startTime);

    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MasterCalendarScreen()),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              // Цветная полоска
              Container(
                width: 4,
                height: 32,
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              // Время
              SizedBox(
                width: 38,
                child: Text(
                  timeStr,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlack,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              // Информация о клиенте и услугах
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          appointment.displayClientName,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlack,
                          ),
                        ),
                        const SizedBox(width: 4),
                        if (appointment.clientPhone.isNotEmpty)
                          Text(
                            '(${appointment.clientPhone})',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        if (isCanceled) ...[
                          const SizedBox(width: 20),
                          Text(
                            'Отменена',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.primaryRed,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 1),
                    Text(
                      appointment.servicesNames.join(', '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              // Цена
              Text(
                appointment.priceDisplay,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
