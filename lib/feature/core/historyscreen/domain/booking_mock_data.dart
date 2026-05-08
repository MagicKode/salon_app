import '../../../checkout/domain/booking_entity.dart';
import '../../bookingservicescreen/domain/add_service_data.dart';

class BookingMockData {
  static List<BookingEntity> get history => [
    BookingEntity(
      services: [
        AddServiceData(id: '1', name: "Женская стрижка", price: 45, durationMinutes: 60),
      ],
      masterName: "Павел",
      dateTime: DateTime.now().add(const Duration(days: 2)),
      price: 45,
      durationMinutes: 60,
      notes: "Хочу более холодный оттенок, чем в прошлый раз. И еще чашечку капучино, если можно!",
    ),
    BookingEntity(
      services: [
        AddServiceData(id: '2', name: "Окрашивание", price: 120, durationMinutes: 90),
      ],
      masterName: "Павел",
      dateTime: DateTime.now().subtract(const Duration(days: 5)),
      price: 120,
      durationMinutes: 90,
      notes: "Хочу более холодный оттенок, чем в прошлый раз. И еще чашечку капучино, если можно!",
    ),
    BookingEntity(
        services: [
          AddServiceData(id: '3', name: "Маникюр", price: 60, durationMinutes: 45),
        ],
      masterName: "Павел",
      dateTime: DateTime.now().subtract(const Duration(days: 10)),
      price: 60,
      durationMinutes: 45
    ),
  ];
}
