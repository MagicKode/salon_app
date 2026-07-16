class EmailValidator {
  static bool isValid(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  static String? validate(String email) {
    if (email.isEmpty) return 'Введите email';
    if (!isValid(email)) return 'Введите корректный email';
    return null;
  }
}
