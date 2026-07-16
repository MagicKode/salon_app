import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/theme/theme_cubit.dart';

class ThemeSwitchTile extends StatelessWidget {
  const ThemeSwitchTile({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ThemeCubit>();
    return SwitchListTile(
      title: const Text('Тёмная тема'),
      value: cubit.state == ThemeMode.dark,
      onChanged: (_) => cubit.toggle(),
    );
  }
}
