enum DayStatus {
  available,
  full,
  dayOff;

  static DayStatus fromString(String status) {
    switch (status.toUpperCase()) {
      case 'AVAILABLE':
        return DayStatus.available;
      case 'FULL':
        return DayStatus.full;
      case 'DAY_OFF':
        return DayStatus.dayOff;
      default:
        return DayStatus.available;
    }
  }
}

// Простая модель для связи даты и её статуса
class DayAvailability {
  final String date;
  final DayStatus status;

  DayAvailability({required this.date, required this.status});

  factory DayAvailability.fromJson(Map<String, dynamic> json) {
    return DayAvailability(
      date: json['date'] as String,
      status: DayStatus.fromString(json['status'] as String? ?? 'AVAILABLE'),
    );
  }
}
