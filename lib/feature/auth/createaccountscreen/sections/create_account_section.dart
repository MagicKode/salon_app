import 'package:flutter/material.dart';
import '../../../../uikit/widgets/app_text_field.dart';

class CreateAccountSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController mobileController;
  final TextEditingController passwordController;
  final ValueNotifier<bool> isPasswordVisible;

  const CreateAccountSection({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.mobileController,
    required this.passwordController,
    required this.isPasswordVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: nameController,
          hintText: "Имя",
          prefixIcon: Icons.person, // Исправлено с email на person
        ),
        const SizedBox(height: 16.0),
        AppTextField(
          controller: emailController,
          hintText: "Email адрес",
          prefixIcon: Icons.email,
        ),
        const SizedBox(height: 16.0),
        AppTextField(
          controller: mobileController,
          hintText: "Телефон",
          prefixIcon: Icons.phone,
        ),
        const SizedBox(height: 16.0),
        AppTextField(
          controller: passwordController,
          hintText: "Пароль",
          prefixIcon: Icons.lock,
          isPassword: true,
          passwordVisibility: isPasswordVisible,
        ),
      ],
    );
  }
}
