import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class UsePhoneNumberSection extends StatelessWidget {
  final VoidCallback onUsePhoneNumberPressed;

  const UsePhoneNumberSection({Key? key, required this.onUsePhoneNumberPressed})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // кликабельная часть
          GestureDetector(
            child: GestureDetector(
              onTap: onUsePhoneNumberPressed,
              child: Text(
                "Номер телефона ?",
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
