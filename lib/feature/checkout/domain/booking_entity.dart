import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../core/bookingservicescreen/domain/add_service_data.dart';

class BookingEntity {
  final int id;
  final List<AddServiceData> services;
  final String masterName;
  final DateTime dateTime;
  final double price;
  final int durationMinutes;
  final String? notes;
  final String status;

  BookingEntity({
    this.id = 0,
    required this.services,
    required this.masterName,
    required this.dateTime,
    required this.price,
    required this.durationMinutes,
    this.notes,
    this.status = 'CONFIRMED',
  });

  /// ИСПРАВЛЕНО: Фабричный метод для создания объекта из JSON ответа бэкенда
  factory BookingEntity.fromJson(Map<String, dynamic> json) {
    // 1. Безопасно парсим дату и время.
    // Если прилетает чистый ISO String ("2026-06-02T16:00:00"), парсим напрямую через DateTime.parse.
    // Если прилетает отдельно дата и время ("2026-06-02" и "16:00:00"), склеиваем их.
    DateTime parsedDateTime;
    try {
      if (json['bookingDateTime'] != null) {
        parsedDateTime = DateTime.parse(json['bookingDateTime'] as String);
      } else {
        final rawDate = json['bookingDate'] as String? ?? '2026-01-01';
        final rawTime = json['bookingTime'] as String? ?? '00:00:00';
        parsedDateTime = DateTime.parse('${rawDate}T$rawTime');
      }
    } catch (e) {
      parsedDateTime = DateTime.now(); // Фолбэк на случай непредвиденного формата
    }

    // Извлекаем общую цену бронирования (в базе это total_price)
    final double totalPrice = (json['totalPrice'] ?? json['total_price'] ?? 0).toDouble();

    // 2. Парсим список услуг на основе логов Hibernate (booking_services -> service_name)
    var servicesList = <AddServiceData>[];

    if (json['services'] != null && json['services'] is List) {
      final List<dynamic> rawServices = json['services'];
      servicesList = rawServices.map((s) {
        // Если внутри массива лежит объект, ищем serviceName/name. Если просто строка — берем её.
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
          price: 0, // На фронте для истории цена лежит в общем инвойсе, внутри AddServiceData ставим 0
          durationMinutes: 30, // Дефолт-заглушка для верстки
        );
      }).toList();
    }

    // Если массив услуг пустой, но в корне есть одиночное поле serviceName (фолбэк)
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

    // 3. Собираем финальную сущность для отображения во Flutter
    return BookingEntity(
      id: json['id'] as int? ?? 0,
      services: servicesList,
      masterName: json['masterName'] ?? json['master_name'] ?? 'Мастер',
      dateTime: parsedDateTime,
      price: totalPrice, // Подставляем реальную общую цену, полученную с бэкенда
      durationMinutes: json['durationMinutes'] ?? json['duration'] ?? 60,
      notes: json['notes'],
      status: json['status'] as String? ?? 'CONFIRMED',
    );
  }

  String get serviceNames => services.map((s) => s.name).join(", ");

  String get formattedDateTime =>
      DateFormat('d MMMM, yyyy - HH:mm', 'ru').format(dateTime);

  String get formattedPrice => '${price.toStringAsFixed(0)} BYN';

  double get calculatedTotalPrice =>
      services.fold(0, (sum, item) => sum + item.price);
}

/// Расширение возможностей списка услуг
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

    return BookingEntity(
      services: this,
      masterName: masterName,
      dateTime: DateTime(
        date.year,
        date.month,
        date.day,
        hour,
        minute,
      ),
      price: totalPrice,
      durationMinutes: totalDuration,
      notes: notes,
    );
  }
}