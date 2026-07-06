import 'package:dio/dio.dart';
import '../../mastercalendarscreen/domain/appointment_model.dart';
import 'day_availability_model.dart';

class MasterScheduleRepository {
  final Dio _dio;
  final String scheduleBaseUrl;

  // 🔥 Кеш для данных месяца (ключ: masterName_год_месяц)
  final Map<String, _CachedMonthData> _cache = {};

  MasterScheduleRepository({
    required Dio dio,
    required this.scheduleBaseUrl,
  }) : _dio = dio;

  Future<List<DayAvailability>> getMonthAvailability(
      String masterName,
      int year,
      int month,
      ) async {
    final key = '${masterName}_${year}_${month}';
    final cached = _cache[key];
    if (cached != null) {
      print('📦 Возвращаем availability из кеша');
      return cached.availability;
    }

    try {
      final response = await _dio.get(
        '$scheduleBaseUrl/month',
        queryParameters: {'year': year, 'month': month},
        options: Options(headers: {'X-User-Name': masterName}),
      );

      final List<dynamic> data = response.data;
      final result = data.map((json) => DayAvailability.fromJson(json)).toList();

      // Сохраняем в кеш (создаём новый объект с пустыми appointment)
      _cache[key] = _CachedMonthData(
        availability: result,
        appointments: [],
      );

      return result;
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Ошибка загрузки сетки календаря');
    }
  }

  Future<List<AppointmentModel>> getMonthAppointments(
      String masterName,
      int year,
      int month,
      ) async {
    final key = '${masterName}_${year}_${month}';
    final cached = _cache[key];
    if (cached != null && cached.appointments.isNotEmpty) {
      print('📦 Возвращаем appointments из кеша');
      return cached.appointments;
    }

    try {
      final response = await _dio.get(
        '$scheduleBaseUrl/appointments',
        queryParameters: {'year': year, 'month': month},
        options: Options(headers: {'X-User-Name': masterName}),
      );

      final List<dynamic> data = response.data;
      final result = data.map((json) => AppointmentModel.fromJson(json)).toList();

      // Обновляем кеш (добавляем appointments)
      if (_cache.containsKey(key)) {
        _cache[key] = _CachedMonthData(
          availability: _cache[key]!.availability,
          appointments: result,
        );
      } else {
        _cache[key] = _CachedMonthData(
          availability: [],
          appointments: result,
        );
      }

      return result;
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Ошибка загрузки списка записей');
    }
  }

  // 🧹 Сброс кеша (например, при выходе из аккаунта)
  void clearCache() {
    _cache.clear();
  }
}

// 👇 ВНУТРЕННИЙ КЛАСС ДЛЯ КЕШИРОВАНИЯ ПАРЫ ДАННЫХ
class _CachedMonthData {
  final List<DayAvailability> availability;
  final List<AppointmentModel> appointments;

  _CachedMonthData({
    required this.availability,
    required this.appointments,
  });
}
