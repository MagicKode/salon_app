import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../../feature/core/masterschedulescreen/domain/day_availability_model.dart';

class CalendarViewCard extends StatelessWidget {
  final DateTime focusedDay;
  final Function(DateTime) onDaySelected;
  // Добавляем карту занятости
  final Map<DateTime, DayStatus> availability;

  const CalendarViewCard({
    super.key,
    required this.focusedDay,
    required this.onDaySelected,
    required this.availability,
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
        calendarFormat: CalendarFormat.month,
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

        // 1. Предикат доступности (Блокирует клики)
        enabledDayPredicate: (day) {
          final status = availability[DateTime(day.year, day.month, day.day)];
          return status != DayStatus.full;
        },

        calendarStyle: CalendarStyle(
          // 2. Стиль для отключенных дней (Серый текст)
          disabledTextStyle: TextStyle(color: Colors.grey.shade400),
          disabledDecoration: const BoxDecoration(shape: BoxShape.circle),

          selectedDecoration: const BoxDecoration(
            color: AppColors.primaryBlue,
            shape: BoxShape.circle,
          ),
          defaultTextStyle: const TextStyle(color: AppColors.primaryBlack),

          // Выходные остаются ярко-красными (как на макете)
          weekendTextStyle: const TextStyle(color: AppColors.primaryRed),
          cellMargin: const EdgeInsets.all(4),
        ),

        // 2. Логика блокировки кликов для выходных
        onDaySelected: (selectedDay, focusedDay) {
          // Если нажали на субботу (6) или воскресенье (7)
          if (selectedDay.weekday == DateTime.saturday ||
              selectedDay.weekday == DateTime.sunday) {
            return;
          }

          onDaySelected(selectedDay);
        },
      ),
    );
  }
}
