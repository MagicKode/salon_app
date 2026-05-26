import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../../uikit/widgets/button/app_button.dart';

class CreateAccountButtonsSection extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onRegisterPressed;

  const CreateAccountButtonsSection({
    super.key,
    required this.isLoading,
    required this.onRegisterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 48.0),
        AppButton(
          text: AppStrings.register,
          onPressed: onRegisterPressed,
          isLoading: isLoading,
        ),
      ],
    );
  }
}
