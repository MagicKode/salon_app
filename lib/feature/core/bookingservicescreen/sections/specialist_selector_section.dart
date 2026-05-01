import 'package:flutter/material.dart';

import '../../../../uikit/assets/app_assets.dart';
import '../../../../uikit/strings/app_strings.dart';

class SpecialistSelectorSection extends StatelessWidget {
  const SpecialistSelectorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
            AppStrings.specialistSection,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(width: 20),
            itemBuilder: (context, index) {
              final isSelected = index == 0;
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? const Color(0xFF1D4D4F) : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage(AppAssets.pavelImg),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                      "Master $index",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? const Color(0xFF1D4D4F) : Colors.black54,
                      )
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
