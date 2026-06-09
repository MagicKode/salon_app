import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/master_calendar_repository.dart';
import 'master_calendar_event.dart';
import 'master_calendar_state.dart';

class MasterCalendarBloc extends Bloc<MasterCalendarEvent, MasterCalendarState> {
  final MasterCalendarRepository _repository;

  MasterCalendarBloc(this._repository) : super(MasterCalendarInitial()) {
    print('🎯 MasterCalendarBloc CREATED');

    on<FetchTodayAppointments>((event, emit) async {

      print('📅 FetchTodayAppointments: ${event.masterName}');  // ✅ Лог

      emit(MasterCalendarLoading());
      try {
        print('🔄 Calling repository...');

        final schedule = await _repository.getTodayAppointments(event.masterName);

        print('✅ Got ${schedule.bookings.length} bookings');

        emit(MasterCalendarSuccess(schedule));
      } catch (e) {

        print('❌ Error: $e');

        emit(MasterCalendarFailure(e.toString().replaceAll('Exception: ', '')));
      }
    });

    on<CancelAppointmentRequested>((event, emit) async {
      print('🗑️ CancelAppointment: ${event.appointmentId}');
      try {
        await _repository.cancelAppointment(event.masterName, event.appointmentId);
        final schedule = await _repository.getTodayAppointments(event.masterName);
        emit(MasterCalendarSuccess(schedule));
      } catch (e) {

        print('❌ Cancel error: $e');

        emit(MasterCalendarFailure(e.toString().replaceAll('Exception: ', '')));
      }
    });
  }
}