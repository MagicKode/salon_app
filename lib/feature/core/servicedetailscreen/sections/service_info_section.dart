import 'package:flutter/material.dart';

class ServiceInfo extends StatelessWidget {
  final String duration;
  final String price;

  const ServiceInfo({super.key, required this.duration, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.access_time, size: 20, color: Colors.blueGrey),
            const SizedBox(width: 8),
            Text(duration, style: const TextStyle(fontSize: 16, color: Colors.blueGrey)),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          price,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF093882)),
        ),
      ],
    );
  }
}
