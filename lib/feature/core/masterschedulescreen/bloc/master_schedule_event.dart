abstract class MasterScheduleEvent {}

class LoadScheduleMonth extends MasterScheduleEvent {
  final String masterName;
  final DateTime month;

  LoadScheduleMonth({
    required this.masterName,
    required this.month,
  });
}

class ChangeSelectedDay extends MasterScheduleEvent {
  final DateTime newDay;
  ChangeSelectedDay(this.newDay);
}
