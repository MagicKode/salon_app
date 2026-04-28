import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/create_account_section.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/sign_in_section.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/term_and_privacy.dart';

import '../../../uikit/widgets/app_button.dart';
import '../../../uikit/widgets/google_button.dart';
import '../../../uikit/widgets/welcome_section.dart';
import '../../core/homepagescreen/sections/background.dart';
import '../../../uikit/widgets/or_divider.dart';

class CreateAccountBody extends StatefulWidget {
  const CreateAccountBody({super.key});

  @override
  _CreateAccountBodyState createState() => _CreateAccountBodyState();
}

class _CreateAccountBodyState extends State<CreateAccountBody> {
  // Контроллеры данных
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Состояние видимости пароля и загрузки
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);
  bool _isLoading = false;
  bool _isGoogleLoading = false;

  // Логика регистрации
  void _register() async {
    setState(() => _isLoading = true);
    // Имитация запроса к Java бэкенду
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _isLoading = false);
  }

  void _signInWithGoogle() async {
    setState(() => _isGoogleLoading = true);
    try {
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      if (mounted) setState(() => _isGoogleLoading = false);
    }
  }

  void _onTermAndPrivacyPressed() {
    // Логика открытия WebView или документа
  }

  void _signIn() {
    // Навигация на LoginScreen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Background(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WelcomeSection(),

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

                  const SizedBox(height: 24.0),

                  AppButton(
                    text: "Join Now",
                    onPressed: _register,
                    isLoading: _isLoading,
                  ),

                  const OrDivider(),

                  GoogleButton(
                    onPressed: _signInWithGoogle,
                    isLoading: _isGoogleLoading,
                  ),

                  SignInSection(onSignInPressed: _signIn),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
