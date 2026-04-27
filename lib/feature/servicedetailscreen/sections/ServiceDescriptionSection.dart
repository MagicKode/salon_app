import 'package:flutter/material.dart';

class ServiceDescriptionSection extends StatelessWidget {
  final String description;
  const ServiceDescriptionSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Описание', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(
          description,
          style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
        ),
      ],
    );
  }
}