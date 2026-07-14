import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../../../../../feature/core/homepagescreen/sections/specialists/domain/master.dart';
import '../specialist_avatar.dart';
import '../specialist_description.dart';
import '../specialist_info.dart';

class SpecialistCard extends StatelessWidget {
  final Master master;

  const SpecialistCard({super.key, required this.master});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SpecialistAvatar(imageUrl: master.imageUrl),
          const SizedBox(width: 8),
          SpecialistInfo(name: master.name, position: master.position),
          const SizedBox(width: 12),
          Container(height: 20, width: 1, color: AppColors.lightBorder),
          const SizedBox(width: 12),
          SpecialistDescription(description: master.description),
        ],
      ),
    );
  }
}
