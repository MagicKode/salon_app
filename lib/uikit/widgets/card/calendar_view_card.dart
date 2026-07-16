import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов
import '../../../feature/core/masterschedulescreen/domain/day_availability_model.dart';
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

  DayStatus? _getDayStatus(DateTime day) {
    final dayKey = DateTime.utc(day.year, day.month, day.day);
    final status = availability[dayKey];
    if (status == null &&
        (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday)) {
      return DayStatus.dayOff;
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Card(
      color: colors.surfaceInput,
      // ✅ динамический фон
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
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary, // ✅ динамический текст заголовка
            ),
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: colors.primaryBlue,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: colors.primaryBlue,
            ),
          ),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: colors.primaryBlue.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: colors.primaryBlue,
              shape: BoxShape.circle,
            ),
            defaultTextStyle: TextStyle(color: colors.textPrimary),
            weekendTextStyle: TextStyle(color: colors.statusError),
            outsideTextStyle: TextStyle(color: colors.textHint),
          ),
          onDaySelected: (selectedDay, focusedDay) {
            final status = _getDayStatus(selectedDay);
            if (status == DayStatus.dayOff) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppStrings.dayOffMessage,
                    style: TextStyle(color: colors.textOnPrimary),
                  ),
                  backgroundColor: colors.statusError,
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

              Color textColor = colors.textPrimary;
              Color? dotColor;
              if (status == DayStatus.dayOff) {
                textColor = colors.statusError;
              } else if (status == DayStatus.full) {
                dotColor = colors.textHint;
              }

              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      isSameDay(day, focusedDay)
                          ? colors.primaryBlue.withOpacity(0.2)
                          : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${day.day}',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.normal,
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
