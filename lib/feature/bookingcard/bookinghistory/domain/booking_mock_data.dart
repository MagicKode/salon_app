import 'booking_history_model.dart';

class BookingMockData {
  static List<BookingHistoryModel> get history => [
    BookingHistoryModel(
      serviceName: "Женская стрижка",
      masterName: "Павел",
      dateTime: DateTime.now().add(const Duration(days: 2)),
      price: "45",
      status: BookingStatus.upcoming,
    ),
    BookingHistoryModel(
      serviceName: "Окрашивание",
      masterName: "Павел",
      dateTime: DateTime.now().subtract(const Duration(days: 5)),
      price: "120",
      status: BookingStatus.completed,
    ),
    BookingHistoryModel(
      serviceName: "Маникюр",
      masterName: "Павел",
      dateTime: DateTime.now().subtract(const Duration(days: 10)),
      price: "60",
      status: BookingStatus.cancelled,
    ),
  ];
}