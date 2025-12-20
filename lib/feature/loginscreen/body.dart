import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/loginscreen/sections/join_now_aection.dart';
import 'package:salon_flutter/feature/loginscreen/sections/or_section.dart';
import 'package:salon_flutter/feature/loginscreen/sections/sign_in_button_section.dart';
import 'package:salon_flutter/feature/loginscreen/sections/sign_in_with_google_section.dart';
import 'package:salon_flutter/feature/loginscreen/sections/welcome_section.dart';

import 'sections/background.dart';
import 'sections/forgot_password_section.dart';
import 'sections/login_form_section.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // Переменные для управления состоянием
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);

  //переменные для отслеживания фокуса полей
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _isLoading = false;
  bool _isGoogleLoading = false;

  void _signIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      // Показать сообщение об ошибке
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Пожалуйста, заполните все поля")));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Имитация загрузки
      await Future.delayed(Duration(seconds: 2));

      // Ваша логика входа
      print("Email: ${_emailController.text}");
      print("Password: ${_passwordController.text}");

      // После успешного входа
      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      print("Ошибка входа: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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

  void _joinNow() {
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

                    // Блок приветствия
                    WelcomeSection(),

                    SizedBox(height: 118.0), // Отступ между текстами

                    // Блок полей для ввода
                    LoginFormSection(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      isPasswordVisible: _isPasswordVisible,
                    ),

                    SizedBox(height: 12.0),

                    // Блок "Забыли пароль?"
                    ForgotPasswordSection(),

                    SizedBox(height: 108.0),

                    //блок кномпа Войти
                    SignInButton(onPressed: _signIn, isLoading: _isLoading),

                    // Разделитель "or"
                    OrDivider(),

                    //блок кнопка Войти с гугл
                    SignInWithGoogleButton(
                      onPressed: _signInWithGoogle,
                      isLoading: _isGoogleLoading,
                    ),

                    // Блок регистрации
                    SignUpSection(onJoinNowPressed: _joinNow),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Не забудьте удалить контроллеры при уничтожении виджета
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _isPasswordVisible.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
