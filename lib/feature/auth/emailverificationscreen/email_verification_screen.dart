import 'package:flutter/material.dart';

import 'email_verification_body.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EmailVerificationBody(),
    );
  }
}