import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/create_account_section.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/join_now_button_section.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/sign_in_section.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/term_and_privacy.dart';

import '../../core/homepagescreen/sections/background.dart';
import '../loginscreen/sections/or_section.dart';
import '../loginscreen/sections/sign_in_with_google_section.dart';
import '../loginscreen/sections/welcome_section.dart';

class CreateAccountBody extends StatefulWidget {
  @override
  _CreateAccountBodyState createState() => _CreateAccountBodyState();
}

class _CreateAccountBodyState extends State<CreateAccountBody> {
  // Переменные для управления состоянием
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);

  //переменные для отслеживания фокуса полей
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _mobileNumberFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _isLoading = false;
  bool _isGoogleLoading = false;

  void _register() async {  //todo add logic for registration
    setState(() {
      _isLoading = true;
    });
  }

  void _signInWithGoogle() async {
    setState(() {
      _isGoogleLoading = true;
    });

    try {
      await Future.delayed(Duration(seconds: 2));
      print("Вход через Google");
    } catch (e) {
      print("Ошибка входа через Google: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isGoogleLoading = false;
        });
      }
    }
  }

  void _onTermAndPrivacyPressed() {
    print("Terms and Privacy нажато");
    // Навигация на экран регистрации
    // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  void _signIn() {
    print("Join Now нажато");
    // Навигация на экран регистрации
    // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Container(
            color: Colors.white,
            child: Background(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //блок приветствия для создания аккаунта
                    WelcomeSection(),

                    SizedBox(height: 38.0),

                    // Блок полей для ввода
                    CreateAccountSection(
                      nameController: _nameController,
                      emailController: _emailController,
                      mobileController: _mobileNumberController,
                      passwordController: _passwordController,
                      isPasswordVisible: _isPasswordVisible,
                    ),

                    SizedBox(height: 12.0),

                    // Блок Политики конфиденциальности
                    TermsAndPrivacy(onTermAndPrivacyPressed: _onTermAndPrivacyPressed),

                    SizedBox(height: 12.0),

                    JoinNowButton(onPressed: _register, isLoading: _isLoading),

                    // Разделитель "or"
                    OrDivider(),

                    //блок кнопка Войти с гугл
                    SignInWithGoogleButton(
                      onPressed: _signInWithGoogle,
                      isLoading: _isGoogleLoading,
                    ),

                    SizedBox(height: 12.0),

                    SignInSection(onJoinNowPressed: _signIn)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }

  // Не забудьте удалить контроллеры при уничтожении виджета
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    _passwordController.dispose();
    _isPasswordVisible.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _mobileNumberFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
