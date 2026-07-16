import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/auth/authblock/domain/repositories/auth_repository.dart';
import 'package:salon_flutter/feature/auth/forgotpasswordscreen/sections/email_validator.dart';
import 'package:salon_flutter/feature/auth/forgotpasswordscreen/sections/forgot_password_state.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import 'package:salon_flutter/uikit/widgets/button/app_button.dart';
import 'package:salon_flutter/uikit/widgets/welcome/welcome_section.dart';
import '../../../config/theme/custom_colors.dart';
import '../../../uikit/widgets/field/app_text_field.dart';

class ForgotPasswordBody extends StatefulWidget {
  const ForgotPasswordBody({super.key});

  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  late ForgotPasswordFormState _state;
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _state = ForgotPasswordFormState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        _validateEmail();
      }
    });
  }

  void _validateEmail() {
    if (!_state.emailTouched && _state.emailError == null) return;
    final error = EmailValidator.validate(_state.email);
    setState(() {
      _state = _state.copyWith(
        emailError: error,
        emailTouched: true,
      );
    });
  }

  Future<void> _sendCode() async {
    final email = _state.email.trim();
    final error = EmailValidator.validate(email);
    if (error != null) {
      setState(() {
        _state = _state.copyWith(emailError: error, emailTouched: true);
      });
      return;
    }

    setState(() => _state = _state.copyWith(isLoading: true));
    try {
      await context.read<AuthRepository>().forgotPassword(email);
      setState(() => _state = _state.copyWith(codeSent: true));
      _showSnackBar(AppStrings.codeSendToEmail, isError: false);
    } catch (e) {
      _showSnackBar("Ошибка: $e", isError: true);
    } finally {
      setState(() => _state = _state.copyWith(isLoading: false));
    }
  }

  Future<void> _resetPassword() async {
    if (_state.newPassword != _state.confirmPassword) {
      _showSnackBar(AppStrings.uncomputablePasswords, isError: true);
      return;
    }
    setState(() => _state = _state.copyWith(isLoading: true));
    try {
      await context.read<AuthRepository>().resetPassword(
        _state.email,
        _state.code,
        _state.newPassword,
      );
      Navigator.popUntil(context, (route) => route.isFirst);
      _showSnackBar(AppStrings.successfulChangedPass, isError: false);
    } catch (e) {
      _showSnackBar("Ошибка: $e", isError: true);
    } finally {
      setState(() => _state = _state.copyWith(isLoading: false));
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: colors.textOnPrimary)),
        backgroundColor: isError ? colors.statusError : colors.statusSuccess,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      backgroundColor: colors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: colors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: colors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const WelcomeSection(
                title: AppStrings.forgotPassword,
                subtitle: AppStrings.forgotPassSubtitle,
              ),
              const SizedBox(height: 80),
              AppTextField(
                controller: TextEditingController(text: _state.email),
                hintText: AppStrings.emailHint,
                prefixIcon: Icons.email_outlined,
                enabled: !_state.codeSent,
                errorText: _state.emailError,
                focusNode: _emailFocusNode,
                onChanged: (value) {
                  setState(() {
                    _state = _state.copyWith(email: value);
                    if (_state.emailTouched) {
                      final error = EmailValidator.validate(value);
                      _state = _state.copyWith(emailError: error);
                    }
                  });
                },
              ),
              if (_state.codeSent) ...[
                const SizedBox(height: 16),
                AppTextField(
                  controller: TextEditingController(text: _state.code),
                  hintText: AppStrings.codeFromTheLetter,
                  prefixIcon: Icons.pin_outlined,
                  onChanged: (value) => setState(() {
                    _state = _state.copyWith(code: value);
                  }),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: TextEditingController(text: _state.newPassword),
                  hintText: AppStrings.newPasswordHint,
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  onChanged: (value) => setState(() {
                    _state = _state.copyWith(newPassword: value);
                  }),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: TextEditingController(text: _state.confirmPassword),
                  hintText: AppStrings.confirmPasswordHint,
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  onChanged: (value) => setState(() {
                    _state = _state.copyWith(confirmPassword: value);
                  }),
                ),
              ],
              const SizedBox(height: 80),
              AppButton(
                text: _state.codeSent ? AppStrings.confirmButton : AppStrings.sendCodeButton,
                onPressed: _state.codeSent ? _resetPassword : _sendCode,
                isLoading: _state.isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }
}
