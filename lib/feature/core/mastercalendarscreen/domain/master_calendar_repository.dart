import 'package:dio/dio.dart';

import 'client_model.dart';
import 'daily_schedule_model.dart';

class MasterCalendarRepository {
  final Dio _dio;
  final String scheduleBaseUrl;
  final String bookingBaseUrl;
  final String clientBaseUrl;

  MasterCalendarRepository({
    required Dio dio,
    required this.scheduleBaseUrl,
    required this.bookingBaseUrl,
    required this.clientBaseUrl,
  }) : _dio = dio;

  Future<Map<String, ClientModel>> getClientsInfo(List<String> phoneNumbers) async {
    if (phoneNumbers.isEmpty) return {};

    try {
      final phones = phoneNumbers.join(',');
      final response = await _dio.get(
        '$clientBaseUrl/batch',
        queryParameters: {'phones': phones},
      );

      if (response.statusCode == 200) {
        final List<dynamic> clients = response.data;
        final Map<String, ClientModel> result = {};
        for (var client in clients) {
          final model = ClientModel.fromJson(client);
          result[model.phoneNumber] = model;
        }
        return result;
      }
      return {};
    } on DioException catch (e) {
      print('Error fetching clients: ${e.message}');
      return {};
    }
  }

  Future<DailyScheduleModel> getTodayAppointments(String masterName) async {
    try {
      print('=== GET TODAY APPOINTMENTS ===');
      print('URL: $scheduleBaseUrl/today');
      print('MasterName: $masterName');

      final response = await _dio.get(
        '$scheduleBaseUrl/today',
        options: Options(headers: {'X-User-Name': masterName}),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        return DailyScheduleModel.fromJson(response.data);
      } else {
        throw Exception('Ошибка загрузки: ${response.statusCode}');
      }
    } on DioException catch (e) {

      print('=== DIO ERROR ===');
      print('Type: ${e.type}');
      print('Message: ${e.message}');
      print('Response: ${e.response?.data}');
      print('==================');

      throw Exception(e.message ?? 'Ошибка сети');
    }
  }

  Future<DailyScheduleModel> getScheduleForDate(
    String masterName,
    DateTime date,
  ) async {
    final dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return _getSchedule('$scheduleBaseUrl/date?date=$dateStr', masterName);
  }

  Future<DailyScheduleModel> _getSchedule(String url, String masterName) async {
    try {
      final response = await _dio.get(
        url,
        options: Options(headers: {'X-User-Name': masterName}),
      );

      if (response.statusCode == 200) {
        return DailyScheduleModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      } else {
        throw Exception('Ошибка загрузки: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['message'] ??
            e.message ??
            'Ошибка сети при получении расписания',
      );
    }
  }

  Future<void> cancelAppointment(String masterName, String appointmentId) async {
    try {
      await _dio.patch(
        '$bookingBaseUrl/$appointmentId/cancel',
        options: Options(headers: {'X-User-Name': masterName}),
      );
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Ошибка сети');
    }
  }
}
