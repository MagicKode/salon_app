import 'package:intl/intl.dart';

class BookingEntity {
  final String serviceName;
  final String masterName;
  final DateTime dateTime;
  final double price;
  final int durationMinutes; // добавили для гибкости

  BookingEntity({
    required this.serviceName,
    required this.masterName,
    required this.dateTime,
    required this.price,
    this.durationMinutes = 60,
  });

  String get formattedDateTime =>
      DateFormat('d MMMM, yyyy - HH:mm', 'ru').format(dateTime);

  String get formattedPrice => '${price.toStringAsFixed(0)} BYN';
}
