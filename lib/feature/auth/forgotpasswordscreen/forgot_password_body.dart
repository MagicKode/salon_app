import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/auth/authblock/domain/repositories/auth_repository.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import 'package:salon_flutter/uikit/widgets/button/app_button.dart';
import 'package:salon_flutter/uikit/widgets/field/app_text_field.dart';
import 'package:salon_flutter/uikit/widgets/welcome/welcome_section.dart';

class ForgotPasswordBody extends StatefulWidget {
  const ForgotPasswordBody({super.key});

  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _codeSent = false;

  Future<void> _sendCode() async {
    if (_emailController.text.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      await context.read<AuthRepository>().forgotPassword(_emailController.text);
      setState(() => _codeSent = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.codeSendToEmail)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ошибка: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _resetPassword() async {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.uncomputablePasswords)),
      );
      return;
    }
    setState(() => _isLoading = true);
    try {
      await context.read<AuthRepository>().resetPassword(
        _emailController.text,
        _codeController.text,
        _newPasswordController.text,
      );
      Navigator.popUntil(context, (route) => route.isFirst);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.successfulChangedPass)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ошибка: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primaryBlack, size: 20),
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
                controller: _emailController,
                hintText: AppStrings.emailHint,
                prefixIcon: Icons.email_outlined,
                enabled: !_codeSent,
              ),
              if (_codeSent) ...[
                const SizedBox(height: 16),
                AppTextField(
                  controller: _codeController,
                  hintText: AppStrings.codeFromTheLetter,
                  prefixIcon: Icons.pin_outlined,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _newPasswordController,
                  hintText: AppStrings.newPasswordHint,
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _confirmPasswordController,
                  hintText: AppStrings.confirmPasswordHint,
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                ),
              ],
              const SizedBox(height: 80),
              AppButton(
                text: _codeSent ? AppStrings.confirmButton : AppStrings.sendCodeButton,
                onPressed: _codeSent ? _resetPassword : _sendCode,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
