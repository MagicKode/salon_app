import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/homepagescreen/home_page_screen.dart';

import '../../feature/auth/authblock/bloc/auth_state.dart';

// Импорты твоих экранов
import '../../feature/auth/loginscreen/login_screen.dart';
import '../auth/authblock/bloc/auth_block.dart';
import '../auth/authblock/domain/entities/user_role.dart';
import 'main_navigation_screen.dart';

class AppRootRouter extends StatelessWidget {
  const AppRootRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // 1. Состояние загрузки (крутилка на старте или при запросе)
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 2. Если авторизация успешна — отправляем на единый экран навигации
        if (state is AuthSuccess) {
          return const MainNavigationScreen();
        }

        // 3. Если не авторизован — на экран логина
        return const LoginScreen();
      },
    );
  }
}
