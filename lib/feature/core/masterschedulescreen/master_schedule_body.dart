import 'package:flutter/material.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../../uikit/widgets/card/calendar_view_card.dart';
import '../../../uikit/widgets/card/day_summary_card.dart';
import '../mastercalendarscreen/domain/appointment_model.dart';
import '../mastercalendarscreen/domain/master_calendar_repository.dart';
import 'master_schedule_screen.dart';

class MasterScheduleBody extends StatelessWidget {
  final DateTime focusedDay;
  final CalendarViewMode viewMode;
  final Function(DateTime) onDaySelected;

  const MasterScheduleBody({
    super.key,
    required this.focusedDay,
    required this.viewMode,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Получаем все записи (из репозитория-заглушки)
    final allAppointments = MasterCalendarRepository.getMockAppointments();

    // 2. Используем твой новый extension для фильтрации по выбранному дню
    final dayAppointments = allAppointments.forDate(focusedDay);

    return Column(
      children: [
        CalendarViewCard(
          focusedDay: focusedDay,
          viewMode: viewMode,
          onDaySelected: onDaySelected,
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(color: AppColors.lightBorder),
        ),

        // Здесь можно добавить краткий список дел на выбранное число
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Передаем отфильтрованные данные в карточку сводки
                DaySummaryCard(
                  appointments: dayAppointments,
                  selectedDate: focusedDay,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
