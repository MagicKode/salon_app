// feature/core/schedule_screen/widgets/master_schedule_body.dart

import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../uikit/colors/app_colors.dart';
import '../../../uikit/widgets/card/calendar_view_card.dart';
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
    return Column(
      children: [
        // Тот самый вынесенный виджет-карточка
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
        const Expanded(
          child: Center(
            child: Text(
              AppStrings.chooseServiceScheduleDay,
              style: TextStyle(color: AppColors.primaryGrey),
            ),
          ),
        ),
      ],
    );
  }
}
