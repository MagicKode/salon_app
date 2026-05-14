import '../../masterschedulescreen/domain/day_availability_model.dart';
import 'appointment_model.dart';

class MasterCalendarRepository {
  static List<AppointmentModel> getMockAppointments() {
    return [
      AppointmentModel(
        id: '1',
        clientName: "Иван Иванов",
        servicesNames: ["Мужская стрижка", "Стрижка бороды"],
        startTime: DateTime.now().add(const Duration(hours: 1)),
        endTime: DateTime.now().add(const Duration(hours: 2)),
        notes: "Просил сделать покороче по бокам, переход 3мм.",
      ),
      AppointmentModel(
        id: '2',
        clientName: "Марина Сергеевна",
        servicesNames: ["Окрашивание"],
        startTime: DateTime.now().add(const Duration(hours: 3)),
        endTime: DateTime.now().add(const Duration(hours: 5)),
      ),
      AppointmentModel(
        id: '3',
        clientName: "Дмитрий Волков",
        servicesNames: ["Стрижка бороды"],
        startTime: DateTime.now().add(const Duration(hours: 6)),
        endTime: DateTime.now().add(const Duration(hours: 7)),
        notes: "Просил сделать покороче по бокам, переход 3мм.",
      ),
      AppointmentModel(
        id: '4',
        clientName: "Иван Иванов",
        servicesNames: ["Мужская стрижка", "Стрижка бороды"],
        startTime: DateTime.now().add(const Duration(hours: 1)),
        endTime: DateTime.now().add(const Duration(hours: 2)),
        notes: "Просил сделать покороче по бокам, переход 3мм.",
      ),
      AppointmentModel(
        id: '5',
        clientName: "Марина Сергеевна",
        servicesNames: ["Окрашивание"],
        startTime: DateTime.now().add(const Duration(hours: 3)),
        endTime: DateTime.now().add(const Duration(hours: 5)),
      ),
      AppointmentModel(
        id: '6',
        clientName: "Дмитрий Волков",
        servicesNames: ["Стрижка бороды"],
        startTime: DateTime.now().add(const Duration(hours: 6)),
        endTime: DateTime.now().add(const Duration(hours: 7)),
        notes: "Просил сделать покороче по бокам, переход 3мм.",
      ),
      AppointmentModel(
        id: '7',
        clientName: "Дмитрий Волков",
        servicesNames: ["Стрижка бороды"],
        startTime: DateTime.now().add(const Duration(hours: 6)),
        endTime: DateTime.now().add(const Duration(hours: 7)),
        notes: "Просил сделать покороче по бокам, переход 3мм.",
      ),
    ];
  }

  static List<AppointmentModel> getEmptyAppointments() => [];

  static Map<DateTime, DayStatus> getMockAvailability() {
    final today = DateTime.now();
    return {
      // Убираем время из даты (Normalization), оставляем только год-месяц-день
      DateTime(today.year, today.month, today.day + 1): DayStatus.full,
      DateTime(today.year, today.month, today.day + 5): DayStatus.full,
      DateTime(today.year, today.month, today.day + 10): DayStatus.dayOff,
    };
  }
}
