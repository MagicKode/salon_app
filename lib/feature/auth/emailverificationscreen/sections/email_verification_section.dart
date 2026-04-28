import 'package:flutter/material.dart';

class EmailVerificationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email верификация,",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 12.0),

          Text(
            "Укажите свой OTP код, который вы получили",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
