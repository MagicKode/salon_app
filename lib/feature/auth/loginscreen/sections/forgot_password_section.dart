import 'package:flutter/material.dart';
import '../../../../config/theme/custom_colors.dart';

class ForgotPasswordSection extends StatelessWidget {
  final VoidCallback onPressed;

  const ForgotPasswordSection({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Text(
              'Забыли пароль?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colors.primaryBlueLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
