import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_repository.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final ThemeRepository repository;

  ThemeCubit({required this.repository}) : super(ThemeMode.system);

  Future<void> loadTheme() async {
    emit(await repository.getThemeMode());
  }

  Future<void> setTheme(ThemeMode mode) async {
    await repository.saveThemeMode(mode);
    emit(mode);
  }

  void toggle() {
    final next = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    setTheme(next);
  }
}
