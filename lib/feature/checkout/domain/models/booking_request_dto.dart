
import 'package:intl/intl.dart';

import '../booking_entity.dart';

class BookingRequestDto {
  final String masterName;
  final String bookingDate; // Ожидает формат "YYYY-MM-DD"
  final String bookingTime; // Ожидает формат "HH:mm:ss"
  final List<String> serviceNames;
  final String notes;
  final int durationMinutes;
  final double totalPrice;

  BookingRequestDto({
    required this.masterName,
    required this.bookingDate,
    required this.bookingTime,
    required this.serviceNames,
    required this.notes,
    required this.durationMinutes,
    required this.totalPrice,
  });

  /// ВЕРНУЛИ НА МЕСТО: Фабричный метод для сборки DTO из сущности во Flutter
  factory BookingRequestDto.fromEntity(BookingEntity entity) {
    final String formattedDate = DateFormat('yyyy-MM-dd').format(entity.dateTime);
    final String formattedTime = DateFormat('HH:mm:00').format(entity.dateTime);
    final List<String> names = entity.services.map((s) => s.name).toList();

    return BookingRequestDto(
      masterName: entity.masterName,
      bookingDate: formattedDate,
      bookingTime: formattedTime,
      serviceNames: names,
      notes: entity.notes ?? "", // Защита от null
      durationMinutes: entity.durationMinutes,
      totalPrice: entity.price,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'masterName': masterName,
      'bookingDate': bookingDate,
      'bookingTime': bookingTime,
      'serviceNames': serviceNames,
      'notes': notes,
      'durationMinutes': durationMinutes,
      'totalPrice': totalPrice,
    };
  }
}
