import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../uikit/widgets/button/app_button.dart';

class LoginButtonsSection extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onSignInPressed;

  const LoginButtonsSection({
    super.key,
    required this.isLoading,
    required this.onSignInPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 100.0),

        AppButton(
          text: AppStrings.signIn,
          onPressed: onSignInPressed,
          isLoading: isLoading,
        ),
      ],
    );
  }
}
