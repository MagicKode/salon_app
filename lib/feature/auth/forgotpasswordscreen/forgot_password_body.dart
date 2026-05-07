import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/auth/forgotpasswordscreen/sections/use_phone_number_sections.dart';

import '../../../uikit/colors/app_colors.dart';
import '../../../uikit/strings/app_strings.dart';
import '../../../uikit/widgets/buttons/app_button.dart';
import '../../../uikit/widgets/inputs/app_text_field.dart';
import '../../../uikit/widgets/welcome/welcome_section.dart';
import '../emailverificationscreen/email_verification_screen.dart';

class ForgotPasswordBody extends StatefulWidget {
  const ForgotPasswordBody({super.key});

  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  void _onUsePhoneNumberPressed() {
    print("Переход на восстановление по номеру телефона");
  }

  void _sendCode() async {
    if (_emailController.text.isEmpty) return;

    setState(() => _isLoading = true);
    // Имитация запроса к API
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);
      print("Код отправлен на ${_emailController.text}");
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
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WelcomeSection(
                title: AppStrings.forgotPassword,
                subtitle: AppStrings.forgotPassSubtitle,
              ),

              const SizedBox(height: 120.0),

              AppTextField(
                controller: _emailController,
                hintText: AppStrings.emailHint,
                prefixIcon: Icons.email_outlined,
              ),

              const SizedBox(height: 12.0),

              UsePhoneNumberSection(onPressed: _onUsePhoneNumberPressed),

              const SizedBox(height: 120.0),

              AppButton(
                text: AppStrings.sendCodeButton,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmailVerificationScreen(),
                    ),
                  );
                },
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
    super.dispose();
  }
}
