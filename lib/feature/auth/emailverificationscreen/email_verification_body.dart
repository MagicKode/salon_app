import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/auth/emailverificationscreen/sections/otp_input_section.dart';
import 'package:salon_flutter/feature/auth/emailverificationscreen/sections/resend_on_time.dart';
import '../../../uikit/colors/app_colors.dart';
import '../../../uikit/strings/app_strings.dart';
import '../../../uikit/widgets/buttons/app_button.dart';
import '../../../uikit/widgets/welcome/welcome_section.dart';

class EmailVerificationBody extends StatefulWidget {
  const EmailVerificationBody({super.key});

  @override
  State<EmailVerificationBody> createState() => _EmailVerificationBodyState();
}

class _EmailVerificationBodyState extends State<EmailVerificationBody> {
  String _otpCode = "";
  bool _isLoading = false;

  void _verifyEmail() async {
    if (_otpCode.length < 4) {
      // Можно добавить SnackBar или анимацию ошибки
      return;
    }

    setState(() => _isLoading = true);

    // Имитация логики API
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);
      print("Код проверен: $_otpCode");
    }
  }

  void _resendCode() {
    print("Запрос на повторную отправку кода");
    // Здесь будет вызов API для повторной отправки
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const WelcomeSection(
                title: AppStrings.verificationTitle,
                subtitle: AppStrings.verificationSubtitle,
              ),

              const SizedBox(height: 120.0),

              OtpInputSection(
                onCodeChanged: (code) {
                  _otpCode = code;
                },
              ),

              const SizedBox(height: 16),

              ResendOnTime(onResendPressed: _resendCode),

              const SizedBox(height: 120.0),

              AppButton(
                text: AppStrings.verifyButton,
                onPressed: _verifyEmail,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
