import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/auth/forgotpasswordscreen/sections/enter_email_section.dart';
import 'package:salon_flutter/feature/auth/forgotpasswordscreen/sections/forgot_pass_section.dart';
import 'package:salon_flutter/feature/auth/forgotpasswordscreen/sections/send_code_button_section.dart';
import 'package:salon_flutter/feature/auth/forgotpasswordscreen/sections/use_phone_number_sections.dart';

import '../forgotpasswordscreen//sections/background.dart';

class ForgotPasswordBody extends StatefulWidget {
  @override
  _ForgotPasswordBodyState createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  // Переменные для управления состоянием
  final TextEditingController _emailController = TextEditingController();

  //переменные для отслеживания фокуса полей
  final FocusNode _emailFocusNode = FocusNode();

  void _onUsePhoneNumberPressed() {
    print("Use phone number нажато");
    // Навигация на номер телефона
    // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  void _sendCode() async {  //todo add logic for send code

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
                    ForgotPassSection(),

                    SizedBox(height: 120.0),

                    // Блок поля для ввода
                    EnterEmailSection(
                      emailController: _emailController,
                    ),

                    SizedBox(height: 12.0),

                    UsePhoneNumberSection(onUsePhoneNumberPressed: _onUsePhoneNumberPressed),

                    SizedBox(height: 120.0),

                    SendCodeButtonSection(onPressed: _sendCode)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );



    // TODO: implement build
    throw UnimplementedError();
  }
}
