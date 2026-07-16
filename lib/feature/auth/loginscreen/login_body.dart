import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/auth/authblock/bloc/auth_block.dart';
import 'package:salon_flutter/feature/auth/authblock/bloc/auth_state.dart';
import 'package:salon_flutter/feature/auth/loginscreen/sections/forgot_password_section.dart';
import 'package:salon_flutter/feature/auth/loginscreen/sections/login_buttons_section.dart';
import 'package:salon_flutter/feature/auth/loginscreen/sections/login_form_section.dart';
import 'package:salon_flutter/feature/auth/loginscreen/sections/login_validator.dart';
import 'package:salon_flutter/feature/auth/loginscreen/sections/sign_up_section.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../config/theme/custom_colors.dart';
import '../../../uikit/widgets/welcome/welcome_section.dart';
import '../../navigation/main_navigation_screen.dart';
import '../authblock/bloc/auth_event.dart';
import '../createaccountscreen/create_acc_screen.dart';
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
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String? _phoneError;
  String? _passwordError;
  bool _phoneTouched = false;
  bool _passwordTouched = false;

  @override
  void initState() {
    super.initState();
    _phoneFocusNode.addListener(() {
      if (!_phoneFocusNode.hasFocus) {
        _phoneTouched = true;
        _validatePhone();
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        _passwordTouched = true;
        _validatePassword();
      }
    });
  }

  void _validatePhone() {
    if (!_phoneTouched && _phoneError == null) return;
    final error = LoginValidator.validatePhone(_phoneController.text);
    setState(() {
      _phoneError = error;
    });
  }

  void _validatePassword() {
    if (!_passwordTouched && _passwordError == null) return;
    final error = LoginValidator.validatePassword(_passwordController.text);
    setState(() {
      _passwordError = error;
    });
  }

  bool _isFormValid() {
    return _phoneController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _phoneError == null &&
        _passwordError == null;
  }

  void _dispatchLoginEvent() {
    _phoneTouched = true;
    _passwordTouched = true;
    _validatePhone();
    _validatePassword();

    if (!_isFormValid()) {
      _showError('Пожалуйста, заполните все поля корректно');
      return;
    }

    // ✅ Сбрасываем старые ошибки перед отправкой
    setState(() {
      _phoneError = null;
      _passwordError = null;
    });

    context.read<AuthBloc>().add(
      AuthLoginRequested(
        phoneNumber: _phoneController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }

  void _showError(String message) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: colors.textOnPrimary),
        ),
        backgroundColor: colors.statusError,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // ✅ Обработка серверной ошибки
  void _handleServerError(String errorMessage) {
    final msg = errorMessage.toLowerCase();
    setState(() {
      // Проверяем, относится ли ошибка к телефону
      if (msg.contains('номер') ||
          msg.contains('телефон') ||
          msg.contains('phone') ||
          msg.contains('not found') ||
          msg.contains('не найден')) {
        _phoneError = errorMessage;
        _passwordError = null;
        _phoneTouched = true;
      }
      // Проверяем, относится ли ошибка к паролю
      else if (msg.contains('пароль') ||
          msg.contains('password') ||
          msg.contains('invalid')) {
        _passwordError = errorMessage;
        _phoneError = null;
        _passwordTouched = true;
      }
      // Если не знаем, к чему относится — показываем общую ошибку
      else {
        _phoneError = null;
        _passwordError = null;
        _showError(errorMessage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          setState(() {
            _phoneError = null;
            _passwordError = null;
          });
          _navigateToMain();
        }
        if (state is AuthFailure) {
          // ✅ Обрабатываем ошибку от сервера
          _handleServerError(state.errorMessage);
        }
      },
      child: Scaffold(
        backgroundColor: colors.backgroundPrimary,
        body: SafeArea(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final isLoading = state is AuthLoading;

              return SingleChildScrollView(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    WelcomeSection(
                      title: AppStrings.loginTitle,
                      subtitle: AppStrings.loginSubtitle,
                    ),
                    const SizedBox(height: 80),
                    LoginFormSection(
                      phoneController: _phoneController,
                      passwordController: _passwordController,
                      isPasswordVisible: _isPasswordVisible,
                      phoneError: _phoneError,
                      passwordError: _passwordError,
                      phoneFocusNode: _phoneFocusNode,
                      passwordFocusNode: _passwordFocusNode,
                      onPhoneChanged: (_) {
                        if (_phoneTouched) {
                          _validatePhone();
                        }
                        // ✅ Сбрасываем серверную ошибку при вводе
                        if (_phoneError != null) {
                          setState(() => _phoneError = null);
                        }
                      },
                      onPasswordChanged: (_) {
                        if (_passwordTouched) {
                          _validatePassword();
                        }
                        // ✅ Сбрасываем серверную ошибку при вводе
                        if (_passwordError != null) {
                          setState(() => _passwordError = null);
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    ForgotPasswordSection(
                      onPressed: _navigateToForgotPassword,
                    ),
                    const SizedBox(height: 48),
                    LoginButtonsSection(
                      isLoading: isLoading,
                      onSignInPressed: _dispatchLoginEvent,
                    ),
                    const SizedBox(height: 16),
                    SignUpSection(onJoinNowPressed: _navigateToCreateAccount),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            },
          ),
        ),
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

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _isPasswordVisible.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
