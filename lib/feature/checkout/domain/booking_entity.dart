import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/bookingservicescreen/domain/add_service_data.dart';

class BookingEntity {
  final List<AddServiceData> services;
  final String masterName;
  final DateTime dateTime;
  final double price;
  final int durationMinutes;
  final String? notes;

  BookingEntity({
    required this.services,
    required this.masterName,
    required this.dateTime,
    required this.price,
    required this.durationMinutes,
    this.notes,
  });

  String get serviceNames => services.map((s) => s.name).join(", ");

  String get formattedDateTime =>
      DateFormat('d MMMM, yyyy - HH:mm', 'ru').format(dateTime);

  String get formattedPrice => '${price.toStringAsFixed(0)} BYN';

  double get calculatedTotalPrice =>
      services.fold(0, (sum, item) => sum + item.price);
}

/// Мы расширяем возможности обычного списка услуг
extension ServiceListExtension on List<AddServiceData> {
  // Считает общую сумму всех услуг в списке
  double get totalPrice => fold(0, (sum, item) => sum + item.price);

  // Считает общую длительность всех услуг
  int get totalDuration => fold(0, (sum, item) => sum + item.durationMinutes);

  // Считает количество слотов (например, 1 слот = 15 минут)
  int get requiredSlots => (totalDuration / 60).ceil();

  // Удобный метод для быстрого превращения списка в сущность бронирования
  BookingEntity toEntity({
    required String masterName,
    required DateTime date,
    required TimeOfDay time,
    String? notes,
  }) {
    return BookingEntity(
      services: this,
      masterName: masterName,
      dateTime: DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      ),
      price: totalPrice,
      durationMinutes: totalDuration,
      notes: notes,
    );
  }
}
