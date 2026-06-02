import '../domain/time_slot_model.dart';

abstract class BookingSlotsState {}

// 1. Начальное состояние — когда экран только открылся
class BookingSlotsInitial extends BookingSlotsState {}

// 2. Состояние загрузки — когда Flutter ждет ответ от Spring Boot
class BookingSlotsLoading extends BookingSlotsState {}

// 3. Успех — сервер вернул массив слотов
class BookingSlotsSuccess extends BookingSlotsState {
  final List<TimeSlotModel> slots; // Сюда прилетит Map из базы [{slotTime: "09:00", available: true}, ...]
  BookingSlotsSuccess({required this.slots});
}

// 4. Ошибка — если упал гейтвей, выключился интернет или бэк выдал 500
class BookingSlotsFailure extends BookingSlotsState {
  final String errorMessage;
  BookingSlotsFailure({required this.errorMessage});
}