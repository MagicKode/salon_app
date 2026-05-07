import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../../uikit/colors/app_colors.dart';
import '../../domain/entities/theme_settings_entity.dart';
import 'app_theme.dart';
import 'theme_repository.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final IThemeRepository repository;

  ThemeCubit(this.repository) : super(ThemeMode.system) {
    _loadSavedTheme();
  }

  Future<void> _loadSavedTheme() async {
    final savedMode = await repository.getThemeMode();
    emit(savedMode);
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    await repository.saveThemeMode(mode);
    emit(mode);

    final brightness = mode == AppThemeMode.dark
        ? Brightness.dark
        : (mode == AppThemeMode.light ? Brightness.light : WidgetsBinding.instance.platformDispatcher.platformBrightness);

    AppColors.setTheme(brightness);
  }

  ThemeData getCurrentTheme() {
    if (state == AppThemeMode.dark) {
      return AppTheme.dark;
    } else if (state == AppThemeMode.light) {
      return AppTheme.light;
    } else {
      // System
      return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark
          ? AppTheme.dark
          : AppTheme.light;
    }
  }
}