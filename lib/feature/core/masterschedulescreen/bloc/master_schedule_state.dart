import '../../mastercalendarscreen/domain/appointment_model.dart';
import '../domain/day_availability_model.dart';

abstract class MasterScheduleState {}

class MasterScheduleInitial extends MasterScheduleState {}
class MasterScheduleLoading extends MasterScheduleState {}

class MasterScheduleSuccess extends MasterScheduleState {
  final List<DayAvailability> availability;
  final List<AppointmentModel> selectedDayAppointments;
  final DateTime selectedDay;

  MasterScheduleSuccess({
    required this.availability,
    required this.selectedDayAppointments,
    required this.selectedDay,
  });
}

class MasterScheduleFailure extends MasterScheduleState {
  final String errorMessage;
  MasterScheduleFailure(this.errorMessage);
}
