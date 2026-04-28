import 'package:flutter/material.dart';

class WelcomeSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const WelcomeSection({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            subtitle,
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
