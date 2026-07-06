import 'appointment_model.dart';

class DailyScheduleModel {
  final List<AppointmentModel> bookings;
  final String firstClientTime;
  final String lastClientTime;
  final int totalBusyMinutes;

  DailyScheduleModel({
    required this.bookings,
    required this.firstClientTime,
    required this.lastClientTime,
    required this.totalBusyMinutes,
  });

  factory DailyScheduleModel.fromJson(Map<String, dynamic> json) {
    print('Parsing DailySchedule: $json'); // Отладка
    return DailyScheduleModel(
      bookings: (json['bookings'] as List<dynamic>?)
          ?.map((e) => AppointmentModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      firstClientTime: json['firstClientTime'] as String? ?? '-',
      lastClientTime: json['lastClientTime'] as String? ?? '-',
      totalBusyMinutes: json['totalBusyMinutes'] as int? ?? 0,
    );
  }
}
