import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/master_calendar_repository.dart';
import '../master_calendar_event.dart';
import '../master_calendar_state.dart';

class MasterCalendarBloc extends Bloc<MasterCalendarEvent, MasterCalendarState> {
  final MasterCalendarRepository _repository;

  MasterCalendarBloc(this._repository) : super(MasterCalendarInitial()) {
    on<FetchTodayAppointments>((event, emit) async {
      emit(MasterCalendarLoading());
      try {
        final schedule = await _repository.getTodayAppointments(event.masterName);
        emit(MasterCalendarSuccess(schedule));
      } catch (e) {
        emit(MasterCalendarFailure(e.toString().replaceAll('Exception: ', '')));
      }
    });

    on<CancelAppointmentRequested>((event, emit) async {
      try {
        await _repository.cancelAppointment(event.masterName, event.appointmentId);
        final schedule = await _repository.getTodayAppointments(event.masterName);
        emit(MasterCalendarSuccess(schedule));
      } catch (e) {
        emit(MasterCalendarFailure(e.toString().replaceAll('Exception: ', '')));
      }
    });
  }
}