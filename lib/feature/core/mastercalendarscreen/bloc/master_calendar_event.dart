abstract class MasterCalendarEvent {
  final String masterName;
  const MasterCalendarEvent(this.masterName);
}

class FetchTodayAppointments extends MasterCalendarEvent {
  const FetchTodayAppointments(super.masterName);
}

class CancelAppointmentRequested extends MasterCalendarEvent {
  final String appointmentId;
  const CancelAppointmentRequested(super.masterName, {required this.appointmentId});
}
