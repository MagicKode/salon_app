import '../../../checkout/domain/booking_entity.dart';

class BookingMockData {
  static List<BookingEntity> get history => [
    BookingEntity(
      serviceName: "Женская стрижка",
      masterName: "Павел",
      dateTime: DateTime.now().add(const Duration(days: 2)),
      price: "45",
    ),
    BookingEntity(
      serviceName: "Окрашивание",
      masterName: "Павел",
      dateTime: DateTime.now().subtract(const Duration(days: 5)),
      price: "120",
    ),
    BookingEntity(
      serviceName: "Маникюр",
      masterName: "Павел",
      dateTime: DateTime.now().subtract(const Duration(days: 10)),
      price: "60",
    ),
  ];
}
