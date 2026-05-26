import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/create_account_buttons_section.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/create_account_section.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/sign_in_section.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/term_and_privacy.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../uikit/widgets/welcome/welcome_section.dart';
import '../../navigation/main_navigation_screen.dart';
import '../fakeauth/bloc/auth_block.dart';
import '../fakeauth/bloc/auth_event.dart';
import '../fakeauth/bloc/auth_state.dart';

class CreateAccountBody extends StatefulWidget {
  const CreateAccountBody({super.key});

  @override
  State<CreateAccountBody> createState() => _CreateAccountBodyState();
}

class _CreateAccountBodyState extends State<CreateAccountBody> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Состояние видимости пароля и загрузки
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    // Оборачиваем экран в BlocConsumer для перехвата сетевых ответов
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // УСПЕХ: Аккаунт создан, токен в secure_storage! Очищаем стек и летим в приложение
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainNavigationScreen(),
            ),
            (route) => false,
          );
        }
        if (state is AuthFailure) {
          // ОШИБКА: Выводим то, что ответил микросервис (например, "Phone already exists")
          _showError(state.errorMessage);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.primaryWhite,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WelcomeSection(
                      title: AppStrings.registerTitle,
                      subtitle: AppStrings.registerSubtitle,
                    ),

                    const SizedBox(height: 38.0),

                    CreateAccountSection(
                      nameController: _nameController,
                      emailController: _emailController,
                      mobileController: _mobileNumberController,
                      passwordController: _passwordController,
                      isPasswordVisible: _isPasswordVisible,
                    ),

                    const SizedBox(height: 12.0),

                    TermsAndPrivacy(
                      onTermAndPrivacyPressed: _onTermAndPrivacyPressed,
                    ),

                    const SizedBox(height: 48.0),

                    CreateAccountButtonsSection(
                      isLoading: state is AuthLoading,
                      onRegisterPressed: _dispatchRegisterEvent,
                    ),

                    SignInSection(onSignInPressed: _signIn),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _dispatchRegisterEvent() {
    if (_mobileNumberController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      _showError(AppStrings.fillThePhoneAndPasswordErrorMessage);
      return;
    }

    context.read<AuthBloc>().add(
      AuthRegisterRequested(
        phoneNumber: _mobileNumberController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }

  void _showError(String message) {
    // Временно выводим сообщение как есть, без наших сокращений
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message.isEmpty ? AppStrings.errorNetwork : message,
          style: const TextStyle(color: AppColors.primaryWhite),
        ),
        backgroundColor: AppColors.primaryRed,
        duration: const Duration(seconds: 6), // Увеличим время, чтобы успеть прочитать
      ),
    );
  }

  void _onTermAndPrivacyPressed() {
    // Логика открытия WebView или документа
  }

  void _signIn() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    _passwordController.dispose();
    _isPasswordVisible.dispose();
    super.dispose();
  }
}
