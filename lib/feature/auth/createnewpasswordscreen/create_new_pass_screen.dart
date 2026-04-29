import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/auth/createnewpasswordscreen/create_new_password_body.dart';

class CreateNewPassScreen extends StatelessWidget {
  const CreateNewPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CreateNewPasswordBody(),
    );
  }
}