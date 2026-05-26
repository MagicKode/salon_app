import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import '../../../../../uikit/colors/app_colors.dart';
import '../../../../../uikit/strings/app_strings.dart';

class DescriptionSection extends StatelessWidget {
  final String name;
  final String address;
  final String description;
  final String workingHours;

  const DescriptionSection({
    super.key,
    required this.name,
    required this.address,
    required this.description,
    required this.workingHours,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 4, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          // Строка с адресом и иконкой геолокации
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 16, color: AppColors.primaryBlue),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  address,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // Строка с временем работы и иконкой часов
          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: AppColors.primaryBlue),
              const SizedBox(width: 6),
              Text(
                'Режим работы: $workingHours',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Заголовок "О нас" / "Описание"
          Text(
            AppStrings.sectionAbout ?? "О нас",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          ExpandableText(
            AppStrings.aboutFullDescription,
            expandText: AppStrings.moreDetails,
            collapseText: AppStrings.hideDetails,
            maxLines: 3,
            linkColor: AppColors.lightBlue,
            linkStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
