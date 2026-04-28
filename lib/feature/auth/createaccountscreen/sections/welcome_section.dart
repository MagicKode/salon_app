import 'package:flutter/material.dart';

import '../../../../uikit/strings/app_strings.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.welcomeTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            AppStrings.welcomeSubtitle,
            style: TextStyle(
              fontSize: 16.0,
              color: Color(0xFF757575),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
