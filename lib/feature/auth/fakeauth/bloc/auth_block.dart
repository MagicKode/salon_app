import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    // Регистрируем обработчики событий
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLoginRequested>(_onLoginRequested);
  }

  Future<void> _onRegisterRequested(
      AuthRegisterRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.register(
        phoneNumber: event.phoneNumber,
        password: event.password,
      );
      emit(AuthSuccess(user: user));
    } on DioException catch (e) {
      // Ловим кастомные ошибки от нашего глобального хэндлера бэкенда
      final backendMessage = e.response?.data['message'] ?? 'Ошибка регистрации';
      emit(AuthFailure(errorMessage: backendMessage));
    } catch (e) {
      emit(AuthFailure(errorMessage: 'Что-то пошло не так: $e'));
    }
  }

  Future<void> _onLoginRequested(
      AuthLoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.login(
        phoneNumber: event.phoneNumber,
        password: event.password,
      );
      emit(AuthSuccess(user: user));
    } on DioException catch (e) {
      // Если бэк вернул 401 Unauthorized с текстом, вытаскиваем его
      final backendMessage = e.response?.data['message'] ?? 'Неверный номер телефона или пароль';
      emit(AuthFailure(errorMessage: backendMessage));
    } catch (e) {
      emit(AuthFailure(errorMessage: 'Не удалось войти: $e'));
    }
  }
}
