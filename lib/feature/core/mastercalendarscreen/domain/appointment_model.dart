class AppointmentModel {
  final String id;
  final String clientName;
  final List<String> servicesNames;
  final DateTime startTime;
  final DateTime endTime;
  final String? notes;

  const AppointmentModel({
    required this.id,
    required this.clientName,
    required this.servicesNames,
    required this.startTime,
    required this.endTime,
    this.notes,
  });

  // Этот геттер нужен, чтобы в закрытой карточке показать только первую услугу
  String get mainService =>
      servicesNames.isNotEmpty ? servicesNames.first : "Услуга";
}

// Расширение для бизнес-логики отображения
extension AppointmentDisplayX on AppointmentModel {
  bool get hasDetails =>
      (notes?.isNotEmpty ?? false) || servicesNames.length > 1;

  String get timeRange {
    final start =
        "${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}";
    final end = "${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}";
    return "$start — $end";
  }
}
