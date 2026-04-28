import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import 'package:flutter/gestures.dart';

import '../../../../uikit/strings/app_strings.dart';

class TermsAndPrivacy extends StatelessWidget {
  final VoidCallback onTermAndPrivacyPressed;

  const TermsAndPrivacy({
    super.key,
    required this.onTermAndPrivacyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          style: const TextStyle(
            color: Color(0xFF757575), // Colors.grey[600]
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'Manrope', // Твой шрифт из проекта
          ),
          children: [
            const TextSpan(text: AppStrings.termsPrefix),
            TextSpan(
              text: AppStrings.termsLink,
              style: const TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTermAndPrivacyPressed,
            ),
          ],
        ),
      ),
    );
  }
}
