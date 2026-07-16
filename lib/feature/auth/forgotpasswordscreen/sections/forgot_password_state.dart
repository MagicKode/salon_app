import 'email_validator.dart';

class ForgotPasswordFormState {
  final String email;
  final String code;
  final String newPassword;
  final String confirmPassword;
  final bool isLoading;
  final bool codeSent;
  final String? emailError;
  final bool emailTouched;

  ForgotPasswordFormState({
    this.email = '',
    this.code = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.isLoading = false,
    this.codeSent = false,
    this.emailError,
    this.emailTouched = false,
  });

  ForgotPasswordFormState copyWith({
    String? email,
    String? code,
    String? newPassword,
    String? confirmPassword,
    bool? isLoading,
    bool? codeSent,
    String? emailError,
    bool? emailTouched,
  }) {
    return ForgotPasswordFormState(
      email: email ?? this.email,
      code: code ?? this.code,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      codeSent: codeSent ?? this.codeSent,
      emailError: emailError ?? this.emailError,
      emailTouched: emailTouched ?? this.emailTouched,
    );
  }

  bool get isEmailValid => email.isNotEmpty && EmailValidator.isValid(email);
}
