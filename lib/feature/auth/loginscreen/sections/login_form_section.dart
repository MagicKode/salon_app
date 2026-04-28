import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
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
          hintText: AppStrings.emailHint,
          prefixIcon: Icons.email_outlined,
        ),
        const SizedBox(height: 16.0),
        AppTextField(
          controller: passwordController,
          hintText: AppStrings.passwordHint,
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          passwordVisibility: isPasswordVisible,
        ),
      ],
    );
  }
}
