import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import 'package:salon_flutter/uikit/widgets/field/app_text_field.dart';
import 'package:salon_flutter/uikit/widgets/welcome/welcome_section.dart';
import 'forgot_password_state.dart';

class ForgotPasswordForm extends StatelessWidget {
  final ForgotPasswordFormState state;
  final Function(String) onEmailChanged;
  final Function(String) onCodeChanged;
  final Function(String) onNewPasswordChanged;
  final Function(String) onConfirmPasswordChanged;
  final VoidCallback onEmailFocusLost;

  const ForgotPasswordForm({
    super.key,
    required this.state,
    required this.onEmailChanged,
    required this.onCodeChanged,
    required this.onNewPasswordChanged,
    required this.onConfirmPasswordChanged,
    required this.onEmailFocusLost,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const WelcomeSection(
          title: AppStrings.forgotPassword,
          subtitle: AppStrings.forgotPassSubtitle,
        ),
        const SizedBox(height: 80),
        AppTextField(
          controller: TextEditingController(text: state.email)..addListener(() {
            onEmailChanged(TextEditingController(text: state.email).text);
          }),
          hintText: AppStrings.emailHint,
          prefixIcon: Icons.email_outlined,
          enabled: !state.codeSent,
          errorText: state.emailError,
          onChanged: onEmailChanged,
        ),
        if (state.codeSent) ...[
          const SizedBox(height: 16),
          AppTextField(
            controller: TextEditingController(text: state.code),
            hintText: AppStrings.codeFromTheLetter,
            prefixIcon: Icons.pin_outlined,
            onChanged: onCodeChanged,
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: TextEditingController(text: state.newPassword),
            hintText: AppStrings.newPasswordHint,
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            onChanged: onNewPasswordChanged,
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: TextEditingController(text: state.confirmPassword),
            hintText: AppStrings.confirmPasswordHint,
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            onChanged: onConfirmPasswordChanged,
          ),
        ],
      ],
    );
  }
}
