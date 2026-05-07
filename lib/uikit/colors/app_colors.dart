import 'dart:ui';

abstract class AppColors {
  // Общие цвета (используются в обеих темах)
  static const Color primaryBlue = Color(0xFF093882);
  static const Color lightBlue = Color(0xFF3498DB);
  static const Color primaryRed = Color(0xFFF44336);
  static const Color primaryGreen = Color(0xFF36C742);
  static const Color starsYellow = Color(0xFFFFC107);

  // Светлая тема
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF8F9FA);
  static const Color lightCard = Color(0xFFF8F9FA);
  static const Color lightBorder = Color(0xFFE0E0E0);
  static const Color lightTextPrimary = Color(0xFF000000);
  static const Color lightTextSecondary = Color(0xFF9E9E9E);

  // Тёмная тема
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCard = Color(0xFF2A2A2A);
  static const Color darkBorder = Color(0xFF333333);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
}
