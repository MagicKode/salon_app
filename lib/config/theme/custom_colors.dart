import 'package:flutter/material.dart';

class CustomColors extends ThemeExtension<CustomColors> {
  final Color primaryBlue;
  final Color primaryBlueLight;
  final Color primaryBlueDark;
  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color surfaceCard;
  final Color surfaceInput;
  final Color textPrimary;
  final Color textSecondary;
  final Color textHint;
  final Color textOnPrimary;
  final Color textDisabled;
  final Color statusSuccess;
  final Color statusError;
  final Color statusWarning;
  final Color statusInfo;
  final Color divider;
  final Color borderLight;
  final Color shadow;
  final Color ratingStar;

  CustomColors({
    required this.primaryBlue,
    required this.primaryBlueLight,
    required this.primaryBlueDark,
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.surfaceCard,
    required this.surfaceInput,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
    required this.textOnPrimary,
    required this.textDisabled,
    required this.statusSuccess,
    required this.statusError,
    required this.statusWarning,
    required this.statusInfo,
    required this.divider,
    required this.borderLight,
    required this.shadow,
    required this.ratingStar,
  });

  @override
  CustomColors copyWith({
    Color? primaryBlue,
    Color? primaryBlueLight,
    Color? primaryBlueDark,
    Color? backgroundPrimary,
    Color? backgroundSecondary,
    Color? surfaceCard,
    Color? surfaceInput,
    Color? textPrimary,
    Color? textSecondary,
    Color? textHint,
    Color? textOnPrimary,
    Color? textDisabled,
    Color? statusSuccess,
    Color? statusError,
    Color? statusWarning,
    Color? statusInfo,
    Color? divider,
    Color? borderLight,
    Color? shadow,
    Color? ratingStar,
  }) {
    return CustomColors(
      primaryBlue: primaryBlue ?? this.primaryBlue,
      primaryBlueLight: primaryBlueLight ?? this.primaryBlueLight,
      primaryBlueDark: primaryBlueDark ?? this.primaryBlueDark,
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      surfaceCard: surfaceCard ?? this.surfaceCard,
      surfaceInput: surfaceInput ?? this.surfaceInput,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textHint: textHint ?? this.textHint,
      textOnPrimary: textOnPrimary ?? this.textOnPrimary,
      textDisabled: textDisabled ?? this.textDisabled,
      statusSuccess: statusSuccess ?? this.statusSuccess,
      statusError: statusError ?? this.statusError,
      statusWarning: statusWarning ?? this.statusWarning,
      statusInfo: statusInfo ?? this.statusInfo,
      divider: divider ?? this.divider,
      borderLight: borderLight ?? this.borderLight,
      shadow: shadow ?? this.shadow,
      ratingStar: ratingStar ?? this.ratingStar,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      primaryBlue: Color.lerp(primaryBlue, other.primaryBlue, t)!,
      primaryBlueLight:
          Color.lerp(primaryBlueLight, other.primaryBlueLight, t)!,
      primaryBlueDark: Color.lerp(primaryBlueDark, other.primaryBlueDark, t)!,
      backgroundPrimary:
          Color.lerp(backgroundPrimary, other.backgroundPrimary, t)!,
      backgroundSecondary:
          Color.lerp(backgroundSecondary, other.backgroundSecondary, t)!,
      surfaceCard: Color.lerp(surfaceCard, other.surfaceCard, t)!,
      surfaceInput: Color.lerp(surfaceInput, other.surfaceInput, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
      textOnPrimary: Color.lerp(textOnPrimary, other.textOnPrimary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      statusSuccess: Color.lerp(statusSuccess, other.statusSuccess, t)!,
      statusError: Color.lerp(statusError, other.statusError, t)!,
      statusWarning: Color.lerp(statusWarning, other.statusWarning, t)!,
      statusInfo: Color.lerp(statusInfo, other.statusInfo, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      borderLight: Color.lerp(borderLight, other.borderLight, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      ratingStar: Color.lerp(ratingStar, other.ratingStar, t)!,
    );
  }

  static CustomColors light() => CustomColors(
    primaryBlue: const Color(0xFF093882),
    primaryBlueLight: const Color(0xFF2A5F9A),
    primaryBlueDark: const Color(0xFF052A5E),
    backgroundPrimary: const Color(0xFFFFFFFF),
    backgroundSecondary: const Color(0x10093882),
    surfaceCard: const Color(0x0D093882),
    surfaceInput: const Color(0xFFFFFFFF),
    textPrimary: const Color(0xFF000000),
    textSecondary: const Color(0xFF444444),
    textHint: const Color(0xFF9E9E9E),
    textOnPrimary: const Color(0xFFFFFFFF),
    textDisabled: const Color(0xFFBDBDBD),
    statusSuccess: const Color(0xFF36C742),
    statusError: const Color(0xFFD32F2F),
    statusWarning: const Color(0xFFF98600),
    statusInfo: const Color(0xFF2196F3),
    divider: const Color(0xFFE0E0E0),
    borderLight: const Color(0xFFE0E0E0),
    shadow: const Color(0x05000000),
    ratingStar: const Color(0xFFFFC107),
  );

  static CustomColors dark() => CustomColors(
    primaryBlue: const Color(0xFF4A7DBF),
    primaryBlueLight: const Color(0xFF6A9CE0),
    primaryBlueDark: const Color(0xFF1A3A6A),
    backgroundPrimary: const Color(0xFF121212),
    backgroundSecondary: const Color(0x1A4A7DBF),
    surfaceCard: const Color(0xFF1E1E1E),
    surfaceInput: const Color(0xFF2C2C2C),
    textPrimary: const Color(0xFFFFFFFF),
    textSecondary: const Color(0xFFB0B0B0),
    textHint: const Color(0xFF888888),
    textOnPrimary: const Color(0xFFFFFFFF),
    textDisabled: const Color(0xFF666666),
    statusSuccess: const Color(0xFF66BB6A),
    statusError: const Color(0xFFEF5350),
    statusWarning: const Color(0xFFFFA726),
    statusInfo: const Color(0xFF42A5F5),
    divider: const Color(0xFF333333),
    borderLight: const Color(0xFF333333),
    shadow: const Color(0x1A000000),
    ratingStar: const Color(0xFFFFD54F),
  );
}
