import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class SignUpSection extends StatelessWidget {
  final VoidCallback onJoinNowPressed;

  const SignUpSection({
    Key? key,
    required this.onJoinNowPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don’t have an account? ",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          GestureDetector(
            onTap: onJoinNowPressed,
            child: Text(
              "Join Now",
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