import 'package:flutter/material.dart';

class SpecialistSelectorSection extends StatelessWidget {
  const SpecialistSelectorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Specialist", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(width: 20),
            itemBuilder: (context, index) {
              bool isSelected = index == 0;
              return Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: isSelected ? const Color(0xFF1D4D4F) : Colors.grey[200],
                    child: const CircleAvatar(radius: 28, backgroundImage: NetworkImage('https://i.pravatar.cc/150')),
                  ),
                  const SizedBox(height: 8),
                  Text("Master $index", style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}