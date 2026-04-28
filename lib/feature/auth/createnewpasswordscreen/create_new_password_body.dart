import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../../uikit/widgets/app_button.dart';
import '../../../../uikit/widgets/app_text_field.dart';
import '../../../../uikit/widgets/welcome_section.dart';

class CreateNewPasswordBody extends StatefulWidget {
  const CreateNewPasswordBody({super.key});

  @override
  State<CreateNewPasswordBody> createState() => _CreateNewPasswordBodyState();
}

class _CreateNewPasswordBodyState extends State<CreateNewPasswordBody> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _isPasswordVisible = ValueNotifier<bool>(false);
  bool _isLoading = false;

  void _confirmNewPass() async {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Пароли не совпадают")),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isLoading = false);
      print(AppStrings.passwordSuccessfullyChanged);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WelcomeSection(
                title: AppStrings.newPassTitle,
                subtitle: AppStrings.newPassSubtitle,
              ),

              const SizedBox(height: 100.0),

              // Поля ввода
              AppTextField(
                controller: _newPasswordController,
                hintText: AppStrings.newPasswordHint,
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                passwordVisibility: _isPasswordVisible,
              ),

              const SizedBox(height: 16.0),

              AppTextField(
                controller: _confirmPasswordController,
                hintText: AppStrings.confirmPasswordHint,
                prefixIcon: Icons.lock_reset_outlined,
                isPassword: true,
                passwordVisibility: _isPasswordVisible,
              ),

              const SizedBox(height: 48.0),

              AppButton(
                text: AppStrings.confirmButton,
                onPressed: _confirmNewPass,
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
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _isPasswordVisible.dispose();
    super.dispose();
  }
}
