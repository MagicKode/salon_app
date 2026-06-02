import '../domain/entities/auth_user.dart';

abstract class AuthState {}

// Начальное состояние (форма пустая, ждем ввода)
class AuthInitial extends AuthState {}

// Крутилка лоадера (отправили запрос на бэк, ждем ответа)
class AuthLoading extends AuthState {}

// Успех (токен получен, сохранян в память, перекидываем пользователя в приложение)
class AuthSuccess extends AuthState {
  final AuthUser user;
  AuthSuccess({required this.user});
}

// Ошибка (например, неверный пароль или пропал интернет)
class AuthFailure extends AuthState {
  final String errorMessage;
  AuthFailure({required this.errorMessage});
}
