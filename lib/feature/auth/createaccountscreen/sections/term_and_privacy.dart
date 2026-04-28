import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class TermsAndPrivacy extends StatelessWidget {
  final VoidCallback onTermAndPrivacyPressed;

  const TermsAndPrivacy({
    Key? key,
    required this.onTermAndPrivacyPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            // Первая строка - обычный текст
            TextSpan(
              text: "При регистрации, вы соглашаетесь с \n",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),

            // Вторая строка - кликабельная часть
            WidgetSpan(
              child: GestureDetector(
                onTap: onTermAndPrivacyPressed,
                child: Text(
                  "Условиями Политики конфиденциальности",
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
      ),
    );
  }
}
