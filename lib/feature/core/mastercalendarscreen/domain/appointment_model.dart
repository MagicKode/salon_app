class AppointmentModel {
  final String id;
  final String clientName;
  final String serviceName;
  final DateTime startTime;
  final DateTime endTime;

  const AppointmentModel({
    required this.id,
    required this.clientName,
    required this.serviceName,
    required this.startTime,
    required this.endTime,
  });
}
