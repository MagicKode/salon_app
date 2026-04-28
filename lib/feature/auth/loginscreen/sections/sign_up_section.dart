import 'package:flutter/material.dart';
import '../../../../uikit/colors/app_colors.dart';

class SignUpSection extends StatelessWidget {
  final VoidCallback onJoinNowPressed;

  const SignUpSection({
    super.key,
    required this.onJoinNowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don’t have an account? ",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.0,
            ),
          ),
          TextButton(
            onPressed: onJoinNowPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              "Join Now",
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
