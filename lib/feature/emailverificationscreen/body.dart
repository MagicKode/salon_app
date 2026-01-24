import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/emailverificationscreen/sections/code_enter_section.dart';
import 'package:salon_flutter/feature/emailverificationscreen/sections/email_verification_button.dart';
import 'package:salon_flutter/feature/emailverificationscreen/sections/email_verification_section.dart';
import 'package:salon_flutter/feature/emailverificationscreen/sections/resend_on_time.dart';

import '../emailverificationscreen//sections/background.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // Переменные для управления состоянием
  final TextEditingController _codeController = TextEditingController();

  //переменные для отслеживания фокуса полей
  final FocusNode _emailFocusNode = FocusNode();

  void _onResendPressedPressed() {
    print("Use phone number нажато");
    // Навигация на номер телефона
    // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  void _verifyEmail() async {  //todo add logic for send code

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
                    EmailVerificationSection(),

                    SizedBox(height: 120.0),

                    // Блок поля для ввода
                    CodeEnterSection(codeController: _codeController),
                    //
                    ResendOnTime(onResendPressed: _onResendPressedPressed),
                    //
                    SizedBox(height: 120.0),
                    //
                    EmailVerificationButton(onPressed: _verifyEmail)
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