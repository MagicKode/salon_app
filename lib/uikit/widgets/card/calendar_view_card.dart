import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../../feature/core/masterschedulescreen/master_schedule_screen.dart';

class CalendarViewCard extends StatelessWidget {
  final DateTime focusedDay;
  final CalendarViewMode viewMode;
  final Function(DateTime) onDaySelected;

  const CalendarViewCard({
    super.key,
    required this.focusedDay,
    required this.viewMode,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.boxDecorationColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryBlue.withOpacity(0.5),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.primaryBlackShadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TableCalendar(
        locale: 'ru_RU',
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: focusedDay,
        // Проверка выбранного дня, чтобы кружок не пропадал
        selectedDayPredicate: (day) => isSameDay(focusedDay, day),
        calendarFormat: viewMode == CalendarViewMode.week
            ? CalendarFormat.week
            : CalendarFormat.month,
        startingDayOfWeek: StartingDayOfWeek.monday,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          selectedDecoration: const BoxDecoration(
            color: AppColors.primaryBlue,
            shape: BoxShape.circle,
          ),
          defaultTextStyle: const TextStyle(color: AppColors.primaryBlack),
          weekendTextStyle: const TextStyle(color: AppColors.primaryRed),
          // Убираем лишние отступы внутри ячеек
          cellMargin: const EdgeInsets.all(4),
        ),
        onDaySelected: (selectedDay, focusedDay) {
          onDaySelected(selectedDay);
        },
      ),
    );
  }
}
