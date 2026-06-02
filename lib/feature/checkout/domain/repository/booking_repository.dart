import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../../core/bookingservicescreen/domain/time_slot_model.dart';
import '../booking_entity.dart';
import '../models/booking_request_dto.dart'; // Скорректируй импорт под свой проект

class BookingRepository {
  final Dio _dio;
  final String baseUrl;

  BookingRepository({required Dio dio, required this.baseUrl}) : _dio = dio;

  /// Метод отправки бронирования на сервер
  Future<bool> sendBooking(BookingEntity booking, String jwtToken) async {
    final dto = BookingRequestDto.fromEntity(booking);
    final jsonData = dto.toJson();

    print("=== [DEBUG] ОТПРАВЛЯЕМЫЙ НА БЭК JSON: $jsonData ===");

    try {
      final response = await _dio.post(
        baseUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $jwtToken',
          },
        ),
        data: dto.toJson(),
      );

      if (response.statusCode == 201) {
        return true; // Успешно создано
      } else if (response.statusCode == 409) {
        throw Exception("Извините, это время уже занято другим клиентом!");
      } else {
        throw Exception("Ошибка сервера: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw Exception("Извините, это время уже занято другим клиентом!");
      }
      throw Exception("Ошибка при отправке брони: ${e.message}");
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TimeSlotModel>> fetchAvailableSlots(
    String masterName,
    DateTime date,
  ) async {
    final String formattedDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    try {
      final response = await _dio.get(
        '$baseUrl/slots',
        queryParameters: {'masterName': masterName, 'date': formattedDate},
      );

      if (response.statusCode == 200) {
        // Если вдруг с бэка летит сразу чистый массив:
        if (response.data is List) {
          final List<dynamic> rawList = response.data;
          // Превращаем каждую мапу в типизированный TimeSlotModel
          return rawList
              .map(
                (json) => TimeSlotModel.fromJson(json as Map<String, dynamic>),
              )
              .toList();
        }
        return [];
      } else {
        throw Exception(
          "Не удалось загрузить слоты. Статус: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      // Если упала сетевая ошибка Dio — вытаскиваем сообщение бэка
      final serverMessage = e.response?.data?['message'];
      throw Exception(serverMessage ?? "Ошибка сети Dio: ${e.message}");
    } catch (e) {
      throw Exception("Ошибка парсинга или локальная ошибка: $e");
    }
  }
}
