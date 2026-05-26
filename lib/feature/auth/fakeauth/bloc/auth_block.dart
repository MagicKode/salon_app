import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    // Регистрируем обработчики событий
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
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
      final backendMessage =
          e.response?.data['message'] ?? AppStrings.incorrectNumberOrPassword;
      emit(AuthFailure(errorMessage: backendMessage));
    } catch (e) {
      emit(AuthFailure(errorMessage: 'Не удалось войти: $e'));
    }
  }

  Future<void> _onLogoutRequested(
      AuthLogoutRequested event,
      Emitter<AuthState> emit,
      ) async {
    try {
      // Если у твоего authRepository есть метод logout (например, для стирания токенов из Secure Storage),
      // раскомментируй строку ниже:
      // await authRepository.logout();

      print("[AuthBloc] Выход из аккаунта успешен. Сбрасываем стейт в AuthInitial.");
    } catch (e) {
      print("[AuthBloc] Ошибка при локальном логауте: $e");
    } finally {
      // В любом случае принудительно возвращаем начальный стейт,
      // чтобы сработал редирект в UI на экран логина
      emit(AuthInitial());
    }
  }
}
