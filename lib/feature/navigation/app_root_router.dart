import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/auth/authblock/bloc/auth_state.dart';

import '../../feature/auth/loginscreen/login_screen.dart';
import '../auth/authblock/bloc/auth_block.dart';
import '../auth/splashscreen/splash_screen.dart';
import 'main_navigation_screen.dart';

class AppRootRouter extends StatelessWidget {
  const AppRootRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading || state is AuthLoading) {
          return const SplashScreen();
        }
        if (state is AuthSuccess) {
          return const MainNavigationScreen();
        }
        return const LoginScreen();
      },
    );
  }
}
