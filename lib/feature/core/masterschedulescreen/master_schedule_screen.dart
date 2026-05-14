import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/masterschedulescreen/sections/schedule_header_section.dart';

import 'master_schedule_body.dart';

enum CalendarViewMode { week, month }

class MasterScheduleScreen extends StatefulWidget {
  const MasterScheduleScreen({super.key});

  @override
  State<MasterScheduleScreen> createState() => _MasterScheduleScreenState();
}

class _MasterScheduleScreenState extends State<MasterScheduleScreen> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScheduleHeaderSection(
        focusedDay: _selectedDay,
      ),
      body: MasterScheduleBody(
        focusedDay: _selectedDay,
        onDaySelected: (day) => setState(() => _selectedDay = day),
      ),
    );
  }
}