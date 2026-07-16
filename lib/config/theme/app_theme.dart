import 'package:flutter/material.dart';
import 'custom_colors.dart';

class AppTheme {
  static ThemeData light() {
    final colors = CustomColors.light();
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primaryBlue,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: colors.backgroundPrimary,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.backgroundPrimary,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primaryBlue,
          foregroundColor: colors.textOnPrimary,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: colors.surfaceInput,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: colors.borderLight),
        ),
      ),
      extensions: [colors],
    );
  }

  static ThemeData dark() {
    final colors = CustomColors.dark();
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primaryBlue,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: colors.backgroundPrimary,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.backgroundPrimary,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primaryBlue,
          foregroundColor: colors.textOnPrimary,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: colors.surfaceInput,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: colors.borderLight),
        ),
      ),
      extensions: [colors],
    );
  }
}
