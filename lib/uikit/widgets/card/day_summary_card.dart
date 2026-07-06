import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../feature/core/mastercalendarscreen/domain/appointment_model.dart';
import '../../../feature/core/masterschedulescreen/domain/day_availability_model.dart';
import '../../colors/app_colors.dart';
import '../../strings/app_strings.dart';

class DaySummaryCard extends StatelessWidget {
  final List<AppointmentModel> appointments;
  final DateTime selectedDate;
  final Map<DateTime, DayStatus> availability;

  const DaySummaryCard({
    super.key,
    required this.appointments,
    required this.selectedDate,
    required this.availability,
  });

  @override
  Widget build(BuildContext context) {
    final dayKey = DateTime.utc(selectedDate.year, selectedDate.month, selectedDate.day);

    // Проверяем статус выбранного дня
    final status = availability[dayKey];

    // Если день выходной – показываем заглушку
    if (status == DayStatus.dayOff) {
      return _buildDayOffWidget(context);
    }

    // Если записей нет – показываем сообщение
    if (appointments.isEmpty) {
      return _buildEmptyWidget(context);
    }

    // Иначе – список записей
    return _buildAppointmentsList(context);
  }

  Widget _buildDayOffWidget(BuildContext context) {
    final isToday = isSameDay(selectedDate, DateTime.now());
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Icon(
            Icons.beach_access_rounded,
            size: 48,
            color: AppColors.primaryGrey.withOpacity(0.5),
          ),
          const SizedBox(height: 12),
          Text(
            isToday ? AppStrings.todayIsDayOff : AppStrings.dayOff,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGrey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isToday
                ? AppStrings.noAppointmentsToday
                : AppStrings.noAppointmentsOnThisDay,
            style: TextStyle(fontSize: 14, color: AppColors.dateGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightBorder, width: 1),
      ),
      child: Column(
        children: [
          Icon(
            Icons.event_note_rounded,
            size: 48,
            color: AppColors.primaryGrey.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 12),
          Text(
            AppStrings.noAppointmentsForSelectedDay,
            style: TextStyle(fontSize: 16, color: AppColors.dateGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentsList(BuildContext context) {
    final sorted = List<AppointmentModel>.from(appointments)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Text(
              '${DateFormat('d MMMM', 'ru').format(selectedDate)}, ${_weekday(selectedDate)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryBlack,
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sorted.length,
            separatorBuilder:
                (_, __) =>
                    const Divider(height: 1, color: AppColors.lightBorder),
            itemBuilder: (context, index) {
              final a = sorted[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
                  child: Text(
                    '${a.startTime.hour}:${a.startTime.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  a.displayClientName,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  a.servicesNames.join(', '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primaryGrey,
                  ),
                ),
                trailing: Text(
                  a.priceDisplay,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  String _weekday(DateTime date) {
    const weekdays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    return weekdays[date.weekday - 1];
  }

  bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
