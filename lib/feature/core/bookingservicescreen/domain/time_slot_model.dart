class TimeSlotModel {
  final String time;
  final bool isAvailable;

  TimeSlotModel({
    required this.time,
    required this.isAvailable,
  });

  /// Создает объект из JSON-мапы, прилетевшей со Spring Boot
  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    return TimeSlotModel(
      time: json['time'] ?? '',
      // Проверяем ВСЕ возможные варианты ключа, которые мог сгенерировать бэк
      isAvailable: json['isAvailable'] ?? json['available'] ?? json['is_available'] ?? true,
    );
  }
}
