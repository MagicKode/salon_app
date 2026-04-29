import 'package:flutter/material.dart';
import '../../../../uikit/colors/app_colors.dart';
import '../../../../uikit/strings/app_strings.dart';

class UsePhoneNumberSection extends StatelessWidget {
  final VoidCallback onPressed;

  const UsePhoneNumberSection({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: onPressed,
          child: const Text(
            AppStrings.usePhoneNumber,
            style: TextStyle(
              color: AppColors.primaryBlue,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
