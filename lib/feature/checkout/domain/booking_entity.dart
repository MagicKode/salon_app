import 'package:intl/intl.dart';

class BookingEntity {
  final String serviceName;
  final String masterName;
  final DateTime dateTime;
  final String price;

  BookingEntity({
    required this.serviceName,
    required this.masterName,
    required this.dateTime,
    required this.price,
  });

  String get formattedDate =>
      DateFormat('MMM d, yyyy - HH:mm', 'ru').format(dateTime);
}
