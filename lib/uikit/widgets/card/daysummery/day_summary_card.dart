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

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.grey.shade50,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: sorted.length,
        separatorBuilder:
            (_, __) => Divider(height: 0.5, color: Colors.grey.shade200),
        itemBuilder: (context, index) {
          final appointment = sorted[index];
          return _buildCompactCard(context, appointment);
        },
      ),
    );
  }

  Widget _buildCompactCard(BuildContext context, AppointmentModel appointment) {
    final now = DateTime.now();
    final isPast = appointment.endTime.isBefore(now);
    final isCurrent =
        appointment.startTime.isBefore(now) && appointment.endTime.isAfter(now);
    final isFuture = appointment.startTime.isAfter(now);

    Color backgroundColor;
    if (isPast) {
      backgroundColor = Colors.grey.shade200;
    } else if (isCurrent) {
      backgroundColor = Colors.green.shade100;
    } else if (isFuture) {
      backgroundColor = Colors.blue.shade50;
    } else {
      backgroundColor = Colors.transparent;
    }

    final timeStr = DateFormat('HH:mm', 'ru').format(appointment.startTime);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Переход на экран с MasterAppointmentCard
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MasterCalendarScreen()),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 40,
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
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryBlack,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${appointment.clientPhone})',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
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
