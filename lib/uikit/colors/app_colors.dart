import 'dart:ui';

class AppColors {
  // ============================================================
  // 1. Брендовые (основные) цвета
  // ============================================================
  static const Color primaryBlue = Color(0xFF093882); // тёмно-синий (логотип)
  static const Color primaryBlueLight = Color(0xFF2A5F9A);
  static const Color primaryBlueDark = Color(0xFF052A5E);

  // ============================================================
  // 2. Фоны и поверхности
  // ============================================================
  static const Color backgroundPrimary = Color(0xFFFFFFFF);    // основной фон экранов
  static const Color backgroundSecondary = Color(0x10093882); // прозрачный синий (для секций)
  static const Color surfaceCard = Color(0x0D093882);         // фон карточек
  static const Color surfaceInput = Color(0xFFFFFFFF);        // поля ввода

  // ============================================================
  // 3. Текст
  // ============================================================
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF444444);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textOnPrimary = Color(0xFFFFFFFF);       // текст на синем фоне
  static const Color textDisabled = Color(0xFFBDBDBD);

  // ============================================================
  // 4. Статусы (сигнальные цвета)
  // ============================================================
  static const Color statusSuccess = Color(0xFF36C742);
  static const Color statusError = Color(0xFFD32F2F);
  static const Color statusWarning = Color(0xFFF98600);
  static const Color statusInfo = Color(0xFF2196F3);

  // ============================================================
  // 5. Границы и разделители
  // ============================================================
  static const Color divider = Color(0xFFE0E0E0);
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color shadow = Color(0x05000000);


  // ============================================================
  // 6. Рейтинг и акценты
  // ============================================================
  static const Color ratingStar = Color(0xFFFFC107);
}
