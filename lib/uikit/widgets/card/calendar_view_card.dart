import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../feature/core/masterschedulescreen/domain/day_availability_model.dart';
import '../../colors/app_colors.dart';
import '../../strings/app_strings.dart';

class CalendarViewCard extends StatelessWidget {
  final DateTime focusedDay;
  final Function(DateTime) onDaySelected;
  final Map<DateTime, DayStatus> availability;

  const CalendarViewCard({
    super.key,
    required this.focusedDay,
    required this.onDaySelected,
    required this.availability,
  });

  // Возвращает статус дня, а если статус не определён, но это суббота или воскресенье – считаем выходным
  DayStatus? _getDayStatus(DateTime day) {
    final dayKey = DateTime.utc(day.year, day.month, day.day);
    final status = availability[dayKey];
    if (status == null && (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday)) {
      return DayStatus.dayOff;
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade200,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: focusedDay,
          calendarFormat: CalendarFormat.month,
          availableCalendarFormats: const {CalendarFormat.month: 'Месяц'},
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            leftChevronIcon: Icon(Icons.chevron_left, color: AppColors.primaryBlue),
            rightChevronIcon: Icon(Icons.chevron_right, color: AppColors.primaryBlue),
          ),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: AppColors.primaryBlue,
              shape: BoxShape.circle,
            ),
            defaultTextStyle: const TextStyle(color: AppColors.primaryBlack),
            weekendTextStyle: const TextStyle(color: AppColors.primaryRed),
            outsideTextStyle: const TextStyle(color: AppColors.primaryGrey),
          ),
          onDaySelected: (selectedDay, focusedDay) {
            final status = _getDayStatus(selectedDay);
            if (status == DayStatus.dayOff) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppStrings.dayOffMessage),
                  backgroundColor: AppColors.primaryRed,
                  duration: const Duration(seconds: 2),
                ),
              );
              return;
            }
            onDaySelected(selectedDay);
          },
          selectedDayPredicate: (day) => isSameDay(day, focusedDay),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              final status = _getDayStatus(day);

              Color textColor = AppColors.primaryBlack;
              Color? dotColor;
              if (status == DayStatus.dayOff) {
                textColor = AppColors.primaryRed;
                // точки не показываем
              } else if (status == DayStatus.full) {
                dotColor = AppColors.primaryGrey;
              }

              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSameDay(day, focusedDay)
                      ? AppColors.primaryBlue.withValues(alpha: 0.2)
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${day.day}',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.normal, // всегда обычный
                      ),
                    ),
                    if (dotColor != null)
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: dotColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
