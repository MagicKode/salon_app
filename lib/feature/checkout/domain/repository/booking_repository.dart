import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/bookingservicescreen/domain/time_slot_model.dart';
import '../booking_entity.dart';
import '../models/booking_request_dto.dart';

class BookingRepository {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;
  final String baseUrl;
  final String historyUrl;

  BookingRepository({
    required Dio dio,
    required FlutterSecureStorage secureStorage,
    required this.baseUrl,
    required this.historyUrl,
  }) : _dio = dio,
        _secureStorage = secureStorage;

  Future<String?> _getToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  Future<String> _getUserPhone() async {
    return await _secureStorage.read(key: 'user_phone') ?? '';
  }

  /// Метод отправки бронирования на сервер
  Future<bool> sendBooking(BookingEntity booking) async {
    final dto = BookingRequestDto.fromEntity(booking);
    final Map<String, dynamic> jsonData = dto.toJson();
    final userPhone = await _getUserPhone();

    try {
      final response = await _dio.post(
        baseUrl,
        data: jsonData,
        options: Options(
          headers: {
            'X-User-Name': userPhone,
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true; // Успешно создано
      } else if (response.statusCode == 409) {
        throw Exception("Извините, это время уже занято!");
      } else {
        throw Exception("Ошибка сервера: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 409) {
          throw Exception("Извините, это время уже занято другим клиентом!");
        }
        final serverMessage =
            e.response?.data?['message'] ?? e.response?.data?['error'];
        if (serverMessage != null) {
          throw Exception("Сервер отклонил запрос: $serverMessage");
        }
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
        queryParameters: {
          'masterName': masterName,
          'date': formattedDate,
          'status': 'CONFIRMED',
        },
      );

      if (response.statusCode == 200) {
        if (response.data is List) {
          final List<dynamic> rawList = response.data;
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
      final serverMessage = e.response?.data?['message'];
      throw Exception(serverMessage ?? "Ошибка сети Dio: ${e.message}");
    }
  }

  Future<bool> cancelBooking(String bookingId) async {
    final token = await _getToken();
    final phone = await _getUserPhone();
    if (token == null || phone.isEmpty) {
      throw Exception('Нет токена или телефона');
    }
    try {
      final response = await _dio.patch(
        '$baseUrl/$bookingId/cancel',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'X-User-Name': phone,
          },
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      debugPrint("Ошибка при отмене бронирования: $e");
      return false;
    }
  }

  Future<bool> updateBookingComment(String bookingId, String newComment) async {
    final token = await _getToken();
    final phone = await _getUserPhone();
    if (token == null || phone.isEmpty) {
      throw Exception('Нет токена или телефона');
    }
    try {
      final response = await _dio.patch(
        '$baseUrl/$bookingId/comment',
        data: {'comment': newComment},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'X-User-Name': phone,
            'Content-Type': 'application/json',
          },
        ),
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      debugPrint("Ошибка при обновлении комментария: $e");
      return false;
    }
  }

  Future<List<BookingEntity>> fetchActiveBookings() async {
    final token = await _getToken();
    final phone = await _getUserPhone();
    if (token == null || phone.isEmpty) {
      throw Exception('Нет токена или телефона');
    }
    final response = await _dio.get(
      '$historyUrl/active',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'X-User-Name': phone,
        },
      ),
    );
    print('📦 Активные записи (сырые): ${response.data}');
    final parsed = _parseBookings(response);
    print('📦 Активные записи (распарсенные): ${parsed.length} шт.');
    return parsed;
  }

  Future<List<BookingEntity>> fetchPastBookings() async {
    final token = await _getToken();
    final phone = await _getUserPhone();
    if (token == null || phone.isEmpty) {
      throw Exception('Нет токена или телефона');
    }
    final response = await _dio.get(
      '$historyUrl/past',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'X-User-Name': phone,
        },
      ),
    );
    return _parseBookings(response);
  }

  List<BookingEntity> _parseBookings(Response response) {
    final List data = response.data;
    return data.map((json) => BookingEntity.fromJson(json)).toList();
  }
}
