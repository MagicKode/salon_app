import 'package:intl/intl.dart';

import '../booking_entity.dart';
class BookingRequestDto {
  final String masterName;
  final String bookingDate; // Ожидает формат "YYYY-MM-DD"
  final String bookingTime; // Ожидает формат "HH:mm:ss"
  final List<String> serviceNames;
  final double totalPrice;
  final String notes;

  BookingRequestDto({
    required this.masterName,
    required this.bookingDate,
    required this.bookingTime,
    required this.serviceNames,
    required this.totalPrice,
    required this.notes,
  });

  /// Чистый фабричный метод, работающий напрямую с твоим BookingEntity
  factory BookingRequestDto.fromEntity(BookingEntity entity) {
    // Извлекаем дату в формате "2026-05-31"
    final String formattedDate = DateFormat('yyyy-MM-dd').format(entity.dateTime);

    // Извлекаем время в формате "13:00:00"
    final String formattedTime = DateFormat('HH:mm:00').format(entity.dateTime);

    // Маппим список объектов услуг в список их названий (List<String>)
    final List<String> names = entity.services.map((s) => s.name).toList();

    return BookingRequestDto(
      masterName: entity.masterName,
      bookingDate: formattedDate,
      bookingTime: formattedTime,
      serviceNames: names,
      totalPrice: entity.price, // Используем поле price из твоей сущности
      notes: entity.notes ?? "", // Защита от null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'masterName': masterName,
      'bookingDate': bookingDate,
      'bookingTime': bookingTime,
      'serviceNames': serviceNames,
      'totalPrice': totalPrice,
      'notes': notes,
    };
  }
}