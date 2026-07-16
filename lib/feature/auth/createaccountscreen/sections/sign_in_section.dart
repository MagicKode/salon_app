import 'package:flutter/material.dart';
import '../../../../config/theme/custom_colors.dart';
import '../../../../uikit/strings/app_strings.dart';

class SignInSection extends StatelessWidget {
  final VoidCallback onSignInPressed;

  const SignInSection({super.key, required this.onSignInPressed});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.alreadyHaveAccount,
            style: TextStyle(
              fontSize: 14,
              color: colors.textSecondary,
            ),
          ),
          const SizedBox(width: 4),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onSignInPressed,
              borderRadius: BorderRadius.circular(4),
              splashColor: colors.primaryBlue.withOpacity(0.15),
              highlightColor: colors.primaryBlue.withOpacity(0.05),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  AppStrings.loginLink,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colors.primaryBlueLight,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
