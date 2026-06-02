import 'package:flutter_bloc/flutter_bloc.dart'; // Скорректируй путь к репозиторию

import '../../../checkout/domain/repository/booking_repository.dart';
import '../domain/time_slot_model.dart';
import 'booking_slots_event.dart';
import 'booking_slots_state.dart';

class BookingSlotsBloc extends Bloc<BookingSlotsEvent, BookingSlotsState> {
  final BookingRepository bookingRepository;

  BookingSlotsBloc({required this.bookingRepository})
    : super(BookingSlotsInitial()) {
    // Обрабатываем событие загрузки
    on<LoadBookingSlotsEvent>((event, emit) async {
      emit(BookingSlotsLoading()); // Говорим UI: "включи крутилку"

      try {
        // Вызываем твой рабочий метод из репозитория
        final List<TimeSlotModel> slots = await bookingRepository
            .fetchAvailableSlots(event.masterName, event.date);

        emit(
          BookingSlotsSuccess(slots: slots),
        ); // Отдаем UI массив слотов времени
      } catch (e) {
        // Если что-то пошло не так — отдаем UI текст ошибки
        emit(
          BookingSlotsFailure(
            errorMessage: e.toString().replaceAll("Exception: ", ""),
          ),
        );
      }
    });
  }
}
