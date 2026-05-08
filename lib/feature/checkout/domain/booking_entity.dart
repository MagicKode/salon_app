import 'package:intl/intl.dart';

class BookingEntity {
  final String serviceName;
  final String masterName;
  final DateTime dateTime;
  final double price;
  final int durationMinutes;
  final String? notes;

  BookingEntity({
    required this.serviceName,
    required this.masterName,
    required this.dateTime,
    required this.price,
    this.durationMinutes = 60,
    this.notes,
  });

  String get formattedDateTime =>
      DateFormat('d MMMM, yyyy - HH:mm', 'ru').format(dateTime);

  String get formattedPrice => '${price.toStringAsFixed(0)} BYN';
}
