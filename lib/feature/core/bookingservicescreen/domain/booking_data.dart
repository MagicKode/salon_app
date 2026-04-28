class BookingData {
  final List<String> selectedServices;
  final String? specialistId;
  final DateTime? date;
  final String? timeSlot;
  final String notes;

  BookingData({
    this.selectedServices = const [],
    this.specialistId,
    this.date,
    this.timeSlot,
    this.notes = '',
  });
}
