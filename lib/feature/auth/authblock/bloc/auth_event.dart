abstract class AuthEvent {}

// Событие нажатия на кнопку "Регистрация"
class AuthRegisterRequested extends AuthEvent {
  final String phoneNumber;
  final String password;
  final String firstName;
  final String email;

  AuthRegisterRequested({
    required this.phoneNumber,
    required this.password,
    required this.firstName,
    required this.email,
  });
}

// Событие нажатия на кнопку "Войти"
class AuthLoginRequested extends AuthEvent {
  final String phoneNumber;
  final String password;

  AuthLoginRequested({required this.phoneNumber, required this.password});
}

// Событие выхода из аккаунта (очистка токенов)
class AuthLogoutRequested extends AuthEvent {}
