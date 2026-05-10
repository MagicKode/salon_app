import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/auth/loginscreen/sections/forgot_password_section.dart';
import 'package:salon_flutter/feature/auth/loginscreen/sections/login_form_section.dart';
import 'package:salon_flutter/feature/auth/loginscreen/sections/sign_up_section.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../uikit/colors/app_colors.dart';
import '../../../uikit/widgets/button/app_button.dart';
import '../../../uikit/widgets/button/google_button.dart';
import '../../../uikit/widgets/welcome/welcome_section.dart';
import '../../../uikit/widgets/or/or_divider.dart';
import '../../navigation/main_navigation_screen.dart';
import '../createaccountscreen/create_acc_screen.dart';
import '../fakeauth/authservice/auth_service.dart';
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
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
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

              ForgotPasswordSection(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 100.0),

              AppButton(
                text: AppStrings.signIn,
                onPressed: _signIn,
                isLoading: _isLoading,
              ),

              const OrDivider(),

              GoogleButton(onPressed: _signInWithGoogle),

              SignUpSection(
                onJoinNowPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateAccountScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- ЭТАП 3: ЛОГИКА АВТОРИЗАЦИИ ---
  void _signIn() async {
    setState(() => _isLoading = true);

    // Имитируем небольшую задержку сети для солидности демо
    await Future.delayed(const Duration(milliseconds: 800));

    final success = AuthService.login(
      _phoneController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (success && mounted) {
      // Логика перенаправления в зависимости от роли
      final user = AuthService.currentUser;

      if (user?.role == 'master') {
        // Здесь в будущем будет переход на экран Павла
        _showDemoMessage("Вход как Мастер: ${user?.name}");
        _navigateToMain();
      } else {
        _navigateToMain();
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Неверный телефон или пароль. Попробуйте (1234567 / 123)",
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }

    // void _signIn() async {  //ВРЕМЕННАЯ ЛОГИКА ДЛЯ ДЕМОНСТРАЦИИ !!!!
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const MainNavigationScreen(),
    //     ),
    //   );
  }

  void _navigateToMain() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
    );
  }

  void _showDemoMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _signInWithGoogle() {
    /* логика */
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _isPasswordVisible.dispose();
    super.dispose();
  }
}
