import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/create_account_body.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CreateAccountBody(),
    );
  }
}
