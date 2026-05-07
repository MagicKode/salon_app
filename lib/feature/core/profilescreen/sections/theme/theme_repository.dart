import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/theme_settings_entity.dart';

abstract class IThemeRepository {
  Future<AppThemeMode> getThemeMode();
  Future<void> saveThemeMode(AppThemeMode mode);
}

class ThemeRepository implements IThemeRepository {
  static const String _themeKey = 'app_theme_mode';

  @override
  Future<AppThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getString(_themeKey);

    if (savedMode == null) return AppThemeMode.system;

    return AppThemeMode.values.firstWhere(
          (mode) => mode.name == savedMode,
      orElse: () => AppThemeMode.system,
    );
  }

  @override
  Future<void> saveThemeMode(AppThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }
}