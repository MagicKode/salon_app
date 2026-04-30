import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum BookingStatus { upcoming, completed, cancelled }

extension BookingStatusX on BookingStatus {
  String get label {
    switch (this) {
      case BookingStatus.upcoming: return "Ожидается";
      case BookingStatus.completed: return "Завершено";
      case BookingStatus.cancelled: return "Отменено";
    }
  }

  Color get color {
    switch (this) {
      case BookingStatus.upcoming: return Colors.blue;
      case BookingStatus.completed: return Colors.green;
      case BookingStatus.cancelled: return Colors.red;
    }
  }
}

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

  String get formattedDate => DateFormat('MMM d, yyyy - HH:mm', 'ru').format(dateTime);
}
