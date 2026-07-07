import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthCheckStatusRequested>(_onCheckStatusRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  // Проверка сессии при старте приложения
  Future<void> _onCheckStatusRequested(
      AuthCheckStatusRequested event,
      Emitter<AuthState> emit,
      ) async {
    final user = await authRepository.getAuthenticatedUser();
    if (user != null) {
      emit(AuthSuccess(user: user));
    } else {
      emit(AuthInitial());
    }
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
        firstName: event.firstName,
        email: event.email,
      );
      emit(AuthSuccess(user: user));
    } on DioException catch (e) {
      // Ловим кастомные ошибки от нашего глобального хэндлера бэкенда
      final backendMessage =
          e.response?.data['message'] ?? AppStrings.errorRegistration;
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
      final message = e.response?.data['message']
          ?? e.response?.data['error']
          ?? e.response?.data['detail']
          ?? AppStrings.incorrectNumberOrPassword;
      emit(AuthFailure(errorMessage: message));
    } catch (e) {
      emit(AuthFailure(errorMessage: 'Не удалось войти: $e'));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.logout();
    emit(AuthInitial());
  }
}
