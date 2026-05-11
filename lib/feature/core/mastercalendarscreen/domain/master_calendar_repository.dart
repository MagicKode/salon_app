import 'appointment_model.dart';

class MasterCalendarRepository {
  // Статический метод, имитирующий получение данных с сервера
  static List<AppointmentModel> getMockAppointments() {
    return [
      AppointmentModel(
        id: '1',
        clientName: "Иван Иванов",
        serviceName: "Мужская стрижка",
        startTime: DateTime.now().add(const Duration(hours: 1)),
        endTime: DateTime.now().add(const Duration(hours: 2)),
      ),
      AppointmentModel(
        id: '2',
        clientName: "Марина Сергеевна",
        serviceName: "Окрашивание",
        startTime: DateTime.now().add(const Duration(hours: 3)),
        endTime: DateTime.now().add(const Duration(hours: 5)),
      ),
      AppointmentModel(
        id: '3',
        clientName: "Дмитрий Волков",
        serviceName: "Стрижка бороды",
        startTime: DateTime.now().add(const Duration(hours: 6)),
        endTime: DateTime.now().add(const Duration(hours: 7)),
      ),
    ];
  }

  // Метод для получения пустого списка (для тестов заглушки с кофе)
  static List<AppointmentModel> getEmptyAppointments() => [];
}
