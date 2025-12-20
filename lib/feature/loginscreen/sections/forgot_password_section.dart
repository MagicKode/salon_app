import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class ForgotPasswordSection extends StatelessWidget {
  const ForgotPasswordSection({Key? key}) : super(key: key);

  void _onForgotPasswordTap(BuildContext context) {
    print("Забыли пароль? нажато");
    // Можно добавить навигацию на экран восстановления пароля
    // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.primaryBlue;

    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () => _onForgotPasswordTap(context),
          child: Text(
            "Забыли пароль?",
            style: TextStyle(
              color: primaryColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
