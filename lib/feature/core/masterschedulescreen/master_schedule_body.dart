import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../../uikit/widgets/card/calendar_view_card.dart';
import '../../../uikit/widgets/card/day_summary_card.dart';
import '../mastercalendarscreen/domain/appointment_model.dart';
import '../mastercalendarscreen/domain/master_calendar_repository.dart';

class MasterScheduleBody extends StatelessWidget {
  final DateTime focusedDay;
  final Function(DateTime) onDaySelected;

  const MasterScheduleBody({
    super.key,
    required this.focusedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Получаем все записи (из репозитория-заглушки)
    final allAppointments = MasterCalendarRepository.getMockAppointments();
    final availability = MasterCalendarRepository.getMockAvailability();

    final dayAppointments = allAppointments.forDate(focusedDay);

    return Column(
      children: [
        CalendarViewCard(
          focusedDay: focusedDay,
          onDaySelected: onDaySelected,
          availability: availability,
        ),

        _buildLegend(),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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

  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _legendItem(AppColors.primaryGrey, AppStrings.dayIsFull),
          const SizedBox(width: 16),
          _legendItem(AppColors.primaryBlue, AppStrings.chosenDay),
          const SizedBox(width: 16),
          _legendItem(AppColors.primaryRed, AppStrings.weekend),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 10, color: AppColors.primaryGrey)),
      ],
    );
  }
}
