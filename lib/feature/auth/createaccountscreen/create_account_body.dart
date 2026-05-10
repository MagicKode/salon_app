import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/create_account_section.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/sign_in_section.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/term_and_privacy.dart';
import 'package:salon_flutter/feature/core/homepagescreen/home_page_screen.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../uikit/widgets/button/app_button.dart';
import '../../../uikit/widgets/button/google_button.dart';
import '../../../uikit/widgets/welcome/welcome_section.dart';
import '../../../uikit/widgets/or/or_divider.dart';
import '../../navigation/main_navigation_screen.dart';
import '../fakeauth/authservice/auth_service.dart';
import '../fakeauth/domain/mock_user.dart';

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

  // --- ЭТАП 3: ОБНОВЛЕННАЯ ЛОГИКА РЕГИСТРАЦИИ ---
  void _register() async {
    // Валидация для демо (просто проверка на пустоту)
    if (_nameController.text.isEmpty || _mobileNumberController.text.isEmpty) {
      _showError("Пожалуйста, заполните Имя и Телефон");
      return;
    }

    setState(() => _isLoading = true);

    // Имитация задержки "запроса к бэкенду"
    await Future.delayed(const Duration(milliseconds: 1500));

    // Создаем пользователя
    final newUser = MockUser(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _mobileNumberController.text.trim(),
      password: _passwordController.text.trim(),
      role: 'client', // По умолчанию регистрируем как клиента
    );

    // Сохраняем в наш AuthService
    AuthService.register(newUser);

    if (mounted) {
      setState(() => _isLoading = false);

      // Переход на главный экран после успешной регистрации
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
            (route) => false, // Очищаем стек навигации
      );
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  // --- ОСТАЛЬНАЯ ЛОГИКА ---
  void _signInWithGoogle() async {
    setState(() => _isGoogleLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    // В моке Google-вход можно просто регистрировать дефолтного юзера
    if (mounted) {
      AuthService.currentUser = MockUser(
        name: "Google User",
        email: "google@test.com",
        phone: "9999999",
        password: "",
      );
      setState(() => _isGoogleLoading = false);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainNavigationScreen())
      );
    }
  }

  void _onTermAndPrivacyPressed() {
    // Логика открытия WebView или документа
  }

  void _signIn() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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

                AppButton(
                  text: AppStrings.register,
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
