import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/mastercalendarscreen/master_calendar_body.dart';
import 'package:salon_flutter/feature/core/mastercalendarscreen/sections/calendar_header_section.dart';

import '../../../uikit/colors/app_colors.dart';

class MasterCalendarScreen extends StatelessWidget {
  const MasterCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: CalendarHeaderSection(selectedDate: DateTime.now()),
      body: const MasterCalendarBody(),
    );
  }
}
