import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../core/bookingservicescreen/domain/add_service_data.dart';

class BookingEntity {
  final int id;
  final String clientName;
  final String clientPhone;
  final List<AddServiceData> services;
  final String masterName;
  final DateTime dateTime;
  final DateTime endTime;
  final double price;
  final int durationMinutes;
  final String? notes;
  final String status;

  BookingEntity({
    this.id = 0,
    required this.clientName,
    required this.clientPhone,
    required this.services,
    required this.masterName,
    required this.dateTime,
    required this.endTime,
    required this.price,
    required this.durationMinutes,
    this.notes,
    this.status = 'CONFIRMED',
  });

  factory BookingEntity.fromJson(Map<String, dynamic> json) {
    // 1. Парсим startTime/bookingDate/bookingTime
    DateTime parsedDateTime;
    try {
      if (json['startTime'] != null) {
        parsedDateTime = DateTime.parse(json['startTime'] as String);
      } else if (json['bookingDateTime'] != null) {
        parsedDateTime = DateTime.parse(json['bookingDateTime'] as String);
      } else {
        final rawDate = json['bookingDate'] as String? ?? '2026-01-01';
        final rawTime = json['bookingTime'] as String? ?? '00:00:00';
        parsedDateTime = DateTime.parse('${rawDate}T$rawTime');
      }
    } catch (e) {
      parsedDateTime = DateTime.now();
    }

    // 2. Парсим durationMinutes – если нет, берём 60
    final int durationMinutes = (json['durationMinutes'] as int?) ?? 60;

    // 3. ✅ Вычисляем endTime: всегда на основе startTime + duration
    final DateTime parsedEndTime = parsedDateTime.add(Duration(minutes: durationMinutes));

    final double totalPrice = (json['totalPrice'] ?? json['total_price'] ?? 0).toDouble();

    // Парсим услуги
    var servicesList = <AddServiceData>[];
    if (json['services'] != null && json['services'] is List) {
      final List<dynamic> rawServices = json['services'];
      servicesList = rawServices.map((s) {
        String currentName = 'Услуга';
        String currentId = UniqueKey().toString();
        if (s is Map) {
          currentName = s['serviceName'] ?? s['name'] ?? s['service_name'] ?? 'Услуга';
          currentId = s['id']?.toString() ?? s['booking_id']?.toString() ?? UniqueKey().toString();
        } else if (s is String) {
          currentName = s;
        }
        return AddServiceData(
          id: currentId,
          name: currentName,
          price: 0,
          durationMinutes: 30,
        );
      }).toList();
    }

    if (servicesList.isEmpty) {
      final singleServiceName = json['serviceName'] ?? json['service_name'];
      if (singleServiceName != null) {
        servicesList = [
          AddServiceData(
            id: json['id']?.toString() ?? UniqueKey().toString(),
            name: singleServiceName as String,
            price: totalPrice,
            durationMinutes: json['durationMinutes'] ?? 60,
          )
        ];
      }
    }

    return BookingEntity(
      id: json['id'] as int? ?? 0,
      clientName: json['clientName'] as String? ?? 'Клиент',
      clientPhone: json['clientPhone'] as String? ?? '',
      services: servicesList,
      masterName: json['masterName'] ?? json['master_name'] ?? 'Мастер',
      dateTime: parsedDateTime,
      endTime: parsedEndTime,
      price: totalPrice,
      durationMinutes: json['durationMinutes'] ?? json['duration'] ?? 60,
      notes: json['notes'],
      status: json['status'] as String? ?? 'CONFIRMED',
    );
  }

  String get serviceNames => services.map((s) => s.name).join(", ");
  String get formattedDateTime => DateFormat('d MMMM, yyyy - HH:mm', 'ru').format(dateTime);
  String get formattedPrice => '${price.toStringAsFixed(0)} BYN';
  double get calculatedTotalPrice => services.fold(0, (sum, item) => sum + item.price);
}

extension ServiceListExtension on List<AddServiceData> {
  double get totalPrice => fold(0, (sum, item) => sum + item.price);
  int get totalDuration => fold(0, (sum, item) => sum + item.durationMinutes);
  int get requiredSlots => (totalDuration / 60).ceil();

  BookingEntity toEntity({
    required String masterName,
    required DateTime date,
    required String time,
    String? notes,
  }) {
    final timeParts = time.split(':');
    final int hour = int.parse(timeParts[0]);
    final int minute = int.parse(timeParts[1]);
    final start = DateTime(date.year, date.month, date.day, hour, minute);
    final end = start.add(Duration(minutes: totalDuration));
    return BookingEntity(
      services: this,
      masterName: masterName,
      dateTime: start,
      endTime: end,
      price: totalPrice,
      durationMinutes: totalDuration,
      notes: notes,
      clientName: '',
      clientPhone: '',
    );
  }
}
