import 'package:flutter/material.dart';

class ServiceInfoSection extends StatelessWidget {
  final String title;
  final String duration;
  final String price;

  const ServiceInfoSection({
    super.key,
    required this.title,
    required this.duration,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.access_time, size: 18, color: Colors.grey[600]),
            const SizedBox(width: 6),
            Text(duration, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          price,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF093882),
          ),
        ),
      ],
    );
  }
}