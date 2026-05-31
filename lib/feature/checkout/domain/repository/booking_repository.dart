import 'dart:convert';

import 'package:http/http.dart' as http;

import '../booking_entity.dart';
import '../models/booking_request_dto.dart'; // Скорректируй импорт под свой проект

class BookingRepository {
  final String baseUrl; // Динамический адрес, передаваемый из main.dart

  BookingRepository({required this.baseUrl});

  /// Метод отправки бронирования на сервер
  Future<bool> sendBooking(BookingEntity booking, String jwtToken) async {
    final url = Uri.parse(baseUrl);

    // Преобразуем сущность в DTO для отправки
    final dto = BookingRequestDto.fromEntity(booking);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode(dto.toJson()),
      );

      if (response.statusCode == 201) {
        return true; // Успешно создано
      } else if (response.statusCode == 409) {
        throw Exception("Извините, это время уже занято другим клиентом!");
      } else {
        throw Exception("Ошибка сервера: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> fetchAvailableSlots(
    String masterName,
    DateTime date,
  ) async {
    final String formattedDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    final url = Uri.parse(
      '$baseUrl/slots?masterName=$masterName&date=$formattedDate',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(
          response.body,
        );
      } else {
        throw Exception("Не удалось загрузить слоты");
      }
    } catch (e) {
      throw Exception("Ошибка сети при загрузке слотов: $e");
    }
  }
}
