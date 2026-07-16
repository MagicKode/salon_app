import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../../uikit/widgets/field/app_text_field.dart';

class CreateAccountSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController mobileController;
  final TextEditingController passwordController;
  final ValueNotifier<bool> isPasswordVisible;
  final String? nameError;
  final String? emailError;
  final String? phoneError;
  final String? passwordError;
  final FocusNode? nameFocusNode;
  final FocusNode? emailFocusNode;
  final FocusNode? phoneFocusNode;
  final FocusNode? passwordFocusNode;

  const CreateAccountSection({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.mobileController,
    required this.passwordController,
    required this.isPasswordVisible,
    this.nameError,
    this.emailError,
    this.phoneError,
    this.passwordError,
    this.nameFocusNode,
    this.emailFocusNode,
    this.phoneFocusNode,
    this.passwordFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: nameController,
          hintText: AppStrings.firstNameHint,
          prefixIcon: Icons.person,
          errorText: nameError,
          focusNode: nameFocusNode,
          onChanged: (_) {},
        ),
        const SizedBox(height: 16.0),
        AppTextField(
          controller: emailController,
          hintText: AppStrings.emailHint,
          prefixIcon: Icons.email,
          errorText: emailError,
          focusNode: emailFocusNode,
          onChanged: (_) {},
        ),
        const SizedBox(height: 16.0),
        AppTextField(
          controller: mobileController,
          hintText: AppStrings.phoneHint,
          prefixIcon: Icons.phone,
          errorText: phoneError,
          focusNode: phoneFocusNode,
          onChanged: (_) {},
        ),
        const SizedBox(height: 16.0),
        AppTextField(
          controller: passwordController,
          hintText: AppStrings.passwordHint,
          prefixIcon: Icons.lock,
          isPassword: true,
          passwordVisibility: isPasswordVisible,
          errorText: passwordError,
          focusNode: passwordFocusNode,
          onChanged: (_) {},
        ),
      ],
    );
  }
}
