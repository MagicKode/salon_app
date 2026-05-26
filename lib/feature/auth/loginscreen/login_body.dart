import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/auth/fakeauth/bloc/auth_block.dart';
import 'package:salon_flutter/feature/auth/fakeauth/bloc/auth_state.dart';
import 'package:salon_flutter/feature/auth/loginscreen/sections/forgot_password_section.dart';
import 'package:salon_flutter/feature/auth/loginscreen/sections/login_buttons_section.dart';
import 'package:salon_flutter/feature/auth/loginscreen/sections/login_form_section.dart';
import 'package:salon_flutter/feature/auth/loginscreen/sections/sign_up_section.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../uikit/colors/app_colors.dart';
import '../../../uikit/widgets/welcome/welcome_section.dart';
import '../../navigation/main_navigation_screen.dart';
import '../createaccountscreen/create_acc_screen.dart';
import '../fakeauth/bloc/auth_event.dart';
import '../forgotpasswordscreen/forgot_password_screen.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _isPasswordVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // УСПЕХ: Токен сохранен на устройстве. Проверяем роль и пускаем в приложение
          if (state.user.role == 'MASTER') {
            // Бэкенд возвращает капсом: CLIENT / MASTER
            _showDemoMessage("Вход как Мастер");
            _navigateToMain();
          } else {
            _navigateToMain();
          }
        }

        if (state is AuthFailure) {
          // ОШИБКА: Показываем точное сообщение от нашего GlobalExceptionHandler бэкенда
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: AppColors.primaryRed,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.primaryWhite,
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  WelcomeSection(
                    title: AppStrings.loginTitle,
                    subtitle: AppStrings.loginSubtitle,
                  ),

                  const SizedBox(height: 118.0),

                  LoginFormSection(
                    phoneController: _phoneController,
                    passwordController: _passwordController,
                    isPasswordVisible: _isPasswordVisible,
                  ),

                  ForgotPasswordSection(onPressed: _navigateToForgotPassword),

                  const SizedBox(height: 100.0),

                  LoginButtonsSection(
                    isLoading: state is AuthLoading,
                    onSignInPressed: _dispatchLoginEvent,
                  ),

                  SignUpSection(onJoinNowPressed: _navigateToCreateAccount),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _dispatchLoginEvent() {
    context.read<AuthBloc>().add(
      AuthLoginRequested(
        phoneNumber: _phoneController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }

  void _navigateToMain() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
    );
  }

  void _navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
    );
  }

  void _navigateToCreateAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
    );
  }

  void _showDemoMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _isPasswordVisible.dispose();
    super.dispose();
  }
}
