import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/auth/loginscreen/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBody(),
    );
  }
}
