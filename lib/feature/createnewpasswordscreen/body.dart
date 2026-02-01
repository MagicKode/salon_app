import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/createnewpasswordscreen/sections/background.dart';
import 'package:salon_flutter/feature/createnewpasswordscreen/sections/confirm_new_password_button_section.dart';
import 'package:salon_flutter/feature/createnewpasswordscreen/sections/create_new_pass_section.dart';
import 'package:salon_flutter/feature/createnewpasswordscreen/sections/new_password_section.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // Переменные для управления состоянием
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  //переменные для отслеживания фокуса полей
  final FocusNode _newPasswordFocusNode = FocusNode();
  final FocusNode _confirmNewPasswordFocusNode = FocusNode();

  void _confirmNewPass() {
    print("Confirm New Password нажато");
    // Навигация на экран регистрации
    // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
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
                    NewPasswordSection(),

                    SizedBox(height: 99.0),

                    // Блок полей для ввода
                    CreateNewPassSection(
                      newPasswordController: _newPasswordController,
                      confirmNewPasswordController: _confirmNewPasswordController,
                    ),

                    SizedBox(height: 48.0),

                    ConfirmNewPasswordButtonSection(
                        onPressed: _confirmNewPass
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
    throw UnimplementedError();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmNewPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }
}
