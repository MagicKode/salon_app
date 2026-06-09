import 'package:dio/dio.dart';
import '../../mastercalendarscreen/domain/appointment_model.dart';
import 'day_availability_model.dart';

class MasterScheduleRepository {
  final Dio _dio;
  final String scheduleBaseUrl;

  MasterScheduleRepository({
    required Dio dio,
    required this.scheduleBaseUrl,
  }) : _dio = dio;

  Future<List<DayAvailability>> getMonthAvailability(
      String masterName,
      int year,
      int month,
      ) async {
    try {
      final response = await _dio.get(
        '$scheduleBaseUrl/month',
        queryParameters: {'year': year, 'month': month},
        options: Options(headers: {'X-User-Name': masterName}),
      );

      final List<dynamic> data = response.data;
      return data.map((json) => DayAvailability.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Ошибка загрузки сетки календаря');
    }
  }

  Future<List<AppointmentModel>> getMonthAppointments(
      String masterName,
      int year,
      int month,
      ) async {
    try {
      print('=== GET MONTH APPOINTMENTS ===');
      print('MasterName: $masterName, Year: $year, Month: $month');

      final response = await _dio.get(
        '$scheduleBaseUrl/appointments',
        queryParameters: {'year': year, 'month': month},
        options: Options(headers: {'X-User-Name': masterName}),
      );


      print('Response status: ${response.statusCode}');
      print('Appointments count: ${(response.data as List).length}');


      final List<dynamic> data = response.data;
      return data.map((json) => AppointmentModel.fromJson(json)).toList();
    } on DioException catch (e) {

      print('=== DIO ERROR ===');
      print('Message: ${e.message}');
      print('Response: ${e.response?.data}');

      throw Exception(e.message ?? 'Ошибка загрузки списка записей');
    }
  }
}
