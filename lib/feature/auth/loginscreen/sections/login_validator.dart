class LoginValidator {
  static String? validatePhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    if (cleaned.isEmpty) return 'Введите номер телефона';
    if (!cleaned.startsWith('+')) return 'Номер должен начинаться с +';
    final digits = cleaned.replaceAll('+', '');
    if (digits.length < 10 || digits.length > 15) {
      return 'Некорректная длина номера';
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) return 'Введите пароль';
    if (password.length < 6) return 'Пароль должен содержать минимум 6 символов';
    return null;
  }
}
