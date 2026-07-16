import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salon_flutter/feature/core/mastercalendarscreen/domain/appointment_model.dart';
import 'package:salon_flutter/feature/core/masterschedulescreen/domain/day_availability_model.dart';

import '../../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов
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

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      physics: const BouncingScrollPhysics(),
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
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    final now = DateTime.now();
    final isPast = appointment.endTime.isBefore(now);
    final isCurrent =
        appointment.startTime.isBefore(now) && appointment.endTime.isAfter(now);
    final isFuture = appointment.startTime.isAfter(now);
    final isCanceled = appointment.status?.toUpperCase() == 'CANCELED';

    Color statusColor;
    if (isCanceled) {
      statusColor = colors.statusError; // ✅ красный
    } else if (isPast) {
      statusColor = colors.textSecondary; // ✅ серый
    } else if (isCurrent) {
      statusColor = colors.statusSuccess; // ✅ зелёный
    } else if (isFuture) {
      statusColor = colors.primaryBlue; // ✅ синий
    } else {
      statusColor = colors.textHint; // ✅ светлый серый
    }

    final timeStr = DateFormat('HH:mm', 'ru').format(appointment.startTime);

    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: colors.surfaceInput,
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
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary, // ✅ динамический чёрный/белый
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
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color:
                                colors
                                    .textPrimary, // ✅ динамический чёрный/белый
                          ),
                        ),
                        const SizedBox(width: 4),
                        if (appointment.clientPhone.isNotEmpty)
                          Text(
                            '(${appointment.clientPhone})',
                            style: TextStyle(
                              fontSize: 11,
                              color:
                                  colors.textSecondary, // ✅ динамический серый
                            ),
                          ),
                        if (isCanceled) ...[
                          const SizedBox(width: 20),
                          Text(
                            'Отменена',
                            style: TextStyle(
                              fontSize: 15,
                              color: colors.statusError,
                              // ✅ динамический красный
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
                        color: colors.textSecondary, // ✅ динамический серый
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              // Цена
              Text(
                appointment.priceDisplay,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: colors.primaryBlue, // ✅ динамический синий
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
