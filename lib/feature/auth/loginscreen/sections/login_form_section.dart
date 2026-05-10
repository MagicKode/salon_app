import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../../uikit/widgets/field/app_text_field.dart';

class LoginFormSection extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final ValueNotifier<bool> isPasswordVisible;

  const LoginFormSection({
    super.key,
    required this.phoneController,
    required this.passwordController,
    required this.isPasswordVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: phoneController,
          hintText: "Номер телефона",
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone, // Чтобы сразу открывалась цифровая клавиатура
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
