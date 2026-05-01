import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/auth/loginscreen/sections/forgot_password_section.dart';
import 'package:salon_flutter/feature/auth/loginscreen/sections/login_form_section.dart';
import 'package:salon_flutter/feature/auth/loginscreen/sections/sign_up_section.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../uikit/widgets/app_button.dart';
import '../../../uikit/widgets/google_button.dart';
import '../../../uikit/widgets/welcome_section.dart';
import '../../../uikit/widgets/or_divider.dart';
import '../../navigation/main_navigation_screen.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _isPasswordVisible = ValueNotifier<bool>(false);
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                emailController: _emailController,
                passwordController: _passwordController,
                isPasswordVisible: _isPasswordVisible,
              ),

              const ForgotPasswordSection(),

              const SizedBox(height: 100.0),

              AppButton(
                text: AppStrings.signIn,
                onPressed: _signIn,
                isLoading: _isLoading,
              ),

              const OrDivider(),

              GoogleButton(onPressed: _signInWithGoogle),

              SignUpSection(onJoinNowPressed: () => Navigator.pop(context)),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {  //ВРЕМЕННАЯ ЛОГИКА ДЛЯ ДЕМОНСТРАЦИИ !!!!
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainNavigationScreen(),
      ),
    );
  }

  void _signInWithGoogle() { /* логика */ }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _isPasswordVisible.dispose();
    super.dispose();
  }
}
