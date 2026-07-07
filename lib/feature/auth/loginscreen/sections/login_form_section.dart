import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../../uikit/widgets/field/app_text_field.dart';

class LoginFormSection extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final ValueNotifier<bool> isPasswordVisible;
  final String? phoneError;
  final String? passwordError;
  final ValueChanged<String>? onPhoneChanged;
  final ValueChanged<String>? onPasswordChanged;

  const LoginFormSection({
    Key? key,
    required this.phoneController,
    required this.passwordController,
    required this.isPasswordVisible,
    this.phoneError,
    this.passwordError,
    this.onPhoneChanged,
    this.onPasswordChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: phoneController,
          hintText: "Номер телефона",
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          errorText: phoneError,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Введите номер телефона';
            }
            final cleaned = value.replaceAll(RegExp(r'[^0-9+]'), '');
            if (!cleaned.startsWith('+')) {
              return 'Номер должен начинаться с +';
            }
            final digits = cleaned.replaceAll('+', '');
            if (digits.length < 10 || digits.length > 15) {
              return 'Некорректная длина номера';
            }
            return null;
          },
          onChanged: onPhoneChanged,
        ),
        const SizedBox(height: 16.0),
        AppTextField(
          controller: passwordController,
          hintText: AppStrings.passwordHint,
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          passwordVisibility: isPasswordVisible,
          errorText: passwordError,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Введите пароль';
            }
            if (value.length < 6) {
              return 'Пароль должен быть не менее 6 символов';
            }
            return null;
          },
          onChanged: onPasswordChanged,
        ),
      ],
    );
  }
}
