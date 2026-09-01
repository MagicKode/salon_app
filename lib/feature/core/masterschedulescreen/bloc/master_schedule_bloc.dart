import 'package:flutter_bloc/flutter_bloc.dart';
import '../../mastercalendarscreen/domain/appointment_model.dart';
import '../domain/day_availability_model.dart';
import '../domain/master_schedule_repository.dart';
import 'master_schedule_event.dart';
import 'master_schedule_state.dart';

class MasterScheduleBloc extends Bloc<MasterScheduleEvent, MasterScheduleState> {
  final MasterScheduleRepository _repository;
  DateTime? _lastLoadedMonth;
  List<AppointmentModel> _allMonthAppointments = [];

  MasterScheduleBloc(this._repository) : super(MasterScheduleInitial()) {
    on<LoadScheduleMonth>(_onLoadScheduleMonth);
    on<ChangeSelectedDay>(_onChangeSelectedDay);
  }

  Future<void> _onLoadScheduleMonth(
      LoadScheduleMonth event,
      Emitter<MasterScheduleState> emit,
      ) async {
    // Сразу показываем загрузку с выбранной датой
    emit(MasterScheduleLoading(event.month));

    // Если месяц уже загружен – просто обновляем день без повторного запроса месяца
    if (_lastLoadedMonth != null &&
        _lastLoadedMonth!.year == event.month.year &&
        _lastLoadedMonth!.month == event.month.month &&
        state is MasterScheduleSuccess) {
      await _loadDayAppointments(event.masterName, event.month, emit);
      return;
    }

    try {
      // Загружаем статусы дней
      final availability = await _repository.getMonthAvailability(
        event.masterName,
        event.month.year,
        event.month.month,
      );

      // Загружаем все записи за месяц
      final monthAppointments = await _repository.getMonthAppointments(
        event.masterName,
        event.month.year,
        event.month.month,
      );

      _allMonthAppointments = monthAppointments;
      _lastLoadedMonth = event.month;

      // Фильтруем записи на выбранный день
      final bookings = _filterAppointmentsByDay(monthAppointments, event.month);

      emit(MasterScheduleSuccess(
        availability: availability,
        selectedDayAppointments: bookings,
        selectedDay: event.month,
      ));
    } catch (e) {
      emit(MasterScheduleFailure(
        e.toString().replaceAll('Exception: ', ''),
        event.month,
      ));
    }
  }

  void _onChangeSelectedDay(
      ChangeSelectedDay event,
      Emitter<MasterScheduleState> emit,
      ) {
    if (state is MasterScheduleSuccess) {
      _loadDayAppointments(event.masterName, event.newDay, emit);
    }
  }

  Future<void> _loadDayAppointments(
      String masterName,
      DateTime day,
      Emitter<MasterScheduleState> emit,
      ) async {
    if (state is! MasterScheduleSuccess) return;
    final currentState = state as MasterScheduleSuccess;

    final bookings = _filterAppointmentsByDay(_allMonthAppointments, day);

    emit(MasterScheduleSuccess(
      availability: currentState.availability,
      selectedDayAppointments: bookings,
      selectedDay: day,
    ));
  }

  List<AppointmentModel> _filterAppointmentsByDay(
      List<AppointmentModel> appointments,
      DateTime day,
      ) {
    return appointments.where((a) =>
    a.startTime.year == day.year &&
        a.startTime.month == day.month &&
        a.startTime.day == day.day
    ).toList();
  }
}