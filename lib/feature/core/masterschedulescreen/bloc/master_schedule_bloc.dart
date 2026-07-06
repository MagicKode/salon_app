import 'package:flutter_bloc/flutter_bloc.dart';
import '../../mastercalendarscreen/domain/appointment_model.dart';
import '../domain/day_availability_model.dart';
import '../domain/master_schedule_repository.dart';
import 'master_schedule_event.dart';
import 'master_schedule_state.dart';

class MasterScheduleBloc extends Bloc<MasterScheduleEvent, MasterScheduleState> {
  final MasterScheduleRepository _repository;
  DateTime? _lastLoadedMonth;

  MasterScheduleBloc(this._repository) : super(MasterScheduleInitial()) {
    on<LoadScheduleMonth>(_onLoadScheduleMonth);
    on<ChangeSelectedDay>(_onChangeSelectedDay);
  }

  Future<void> _onLoadScheduleMonth(
      LoadScheduleMonth event,
      Emitter<MasterScheduleState> emit,
      ) async {
    // Проверяем, не загружали ли уже этот месяц
    if (_lastLoadedMonth != null &&
        _lastLoadedMonth!.year == event.month.year &&
        _lastLoadedMonth!.month == event.month.month &&
        state is MasterScheduleSuccess) {

      // Если уже загружены данные за этот месяц, просто обновляем выбранный день
      final currentState = state as MasterScheduleSuccess;
      emit(MasterScheduleSuccess(
        availability: currentState.availability,
        allAppointments: currentState.allAppointments,
        selectedDay: event.month,
      ));
      return;
    }

    emit(MasterScheduleLoading());
    try {
      final results = await Future.wait([
        _repository.getMonthAvailability(event.masterName, event.month.year, event.month.month),
        _repository.getMonthAppointments(event.masterName, event.month.year, event.month.month),
      ]);
      emit(MasterScheduleSuccess(
        availability: results[0] as List<DayAvailability>,
        allAppointments: results[1] as List<AppointmentModel>,
        selectedDay: event.month,
      ));
    } catch (e) {
      emit(MasterScheduleFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  void _onChangeSelectedDay(
      ChangeSelectedDay event,
      Emitter<MasterScheduleState> emit,
      ) {
    if (state is MasterScheduleSuccess) {
      final currentState = state as MasterScheduleSuccess;
      emit(MasterScheduleSuccess(
        availability: currentState.availability,
        allAppointments: currentState.allAppointments,
        selectedDay: event.newDay,
      ));
    }
  }
}
