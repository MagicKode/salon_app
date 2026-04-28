enum BookingStatus { upcoming, completed, cancelled }

class BookingHistoryModel {
  final String serviceName;
  final String masterName;
  final DateTime dateTime;
  final String price;
  final BookingStatus status;

  BookingHistoryModel({
    required this.serviceName,
    required this.masterName,
    required this.dateTime,
    required this.price,
    required this.status,
  });
}
