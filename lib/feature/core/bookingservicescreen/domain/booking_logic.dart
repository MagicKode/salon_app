import 'package:flutter/material.dart';

import '../../../checkout/domain/booking_entity.dart';
import 'add_service_data.dart';

extension ServiceListExtension on List<AddServiceData> {
  // Суммарная цена
  double get totalPrice => fold(0.0, (sum, item) => sum + item.price);

  // Суммарная длительность
  int get totalDuration => fold(0, (sum, item) => sum + item.durationMinutes);

  // Сколько слотов по 60 минут требуется
  int get requiredSlots => (totalDuration / 60).ceil();

  BookingEntity toEntity({
    required String masterName,
    required DateTime date,
    required TimeOfDay time,
    String? notes
  }) {
    return BookingEntity(
      serviceName: map((s) => s.name).join(", "),
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
