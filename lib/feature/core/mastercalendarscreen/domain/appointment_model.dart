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

extension AppointmentStatsX on List<AppointmentModel> {
  /// Фильтрует список, оставляя записи только за выбранный день
  List<AppointmentModel> forDate(DateTime date) {
    return where((a) =>
    a.startTime.year == date.year &&
        a.startTime.month == date.month &&
        a.startTime.day == date.day
    ).toList();
  }

  /// Считает суммарную нагрузку в часах для списка записей
  int totalWorkHours() {
    // Используем inMinutes, чтобы не терять точность при сложении разных услуг
    final totalMinutes = fold(0, (sum, a) =>
    sum + a.endTime.difference(a.startTime).inMinutes);
    return (totalMinutes / 60).round();
  }
}
