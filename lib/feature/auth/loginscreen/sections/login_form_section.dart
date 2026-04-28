import 'package:flutter/material.dart';
import '../../../../uikit/widgets/app_text_field.dart';

class LoginFormSection extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final ValueNotifier<bool> isPasswordVisible;

  const LoginFormSection({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: emailController,
          hintText: "Email",
          prefixIcon: Icons.email_outlined,
        ),
        const SizedBox(height: 16.0),
        AppTextField(
          controller: passwordController,
          hintText: "Password",
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          passwordVisibility: isPasswordVisible,
        ),
      ],
    );
  }
}
