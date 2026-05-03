enum AppThemeMode { system, light, dark }

class ThemeSettingsEntity {
  final AppThemeMode currentMode;
  final bool isSystemThemeActive;

  const ThemeSettingsEntity({
    required this.currentMode,
    required this.isSystemThemeActive,
  });
}
