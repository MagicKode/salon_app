enum DayStatus { available, full, dayOff }

// Простая модель для связи даты и её статуса
class DayAvailability {
  final DateTime date;
  final DayStatus status;

  DayAvailability({required this.date, required this.status});
}
