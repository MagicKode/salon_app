import '../domain/daily_schedule_model.dart';

abstract class MasterCalendarState {}

class MasterCalendarInitial extends MasterCalendarState {}

class MasterCalendarLoading extends MasterCalendarState {}

class MasterCalendarSuccess extends MasterCalendarState {
  final DailyScheduleModel dailySchedule;
  MasterCalendarSuccess(this.dailySchedule);
}

class MasterCalendarFailure extends MasterCalendarState {
  final String errorMessage;
  MasterCalendarFailure(this.errorMessage);
}
