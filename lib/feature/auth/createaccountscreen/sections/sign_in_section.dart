import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../../../../uikit/strings/app_strings.dart';

class SignInSection extends StatelessWidget {
  final VoidCallback onSignInPressed;

  const SignInSection({super.key, required this.onSignInPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            AppStrings.alreadyHaveAccount,
            style: TextStyle(color: Color(0xFF757575), fontSize: 14.0),
          ),
          GestureDetector(
            onTap: onSignInPressed,
            child: const Text(
              AppStrings.loginLink,
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
