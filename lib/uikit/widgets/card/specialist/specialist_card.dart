import 'package:flutter/material.dart';

import '../../../../../../uikit/colors/app_colors.dart';
import '../../../../feature/core/homepagescreen/sections/specialists/domain/master.dart';
import '../images/networkimagewithplaceholder.dart';

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
          // 1. Фото
          ClipOval(
            child: NetworkImageWithPlaceholder(
              url: master.imageUrl,
              fit: BoxFit.cover,
              width: 70,
              height: 70,
              errorWidget: const Icon(Icons.person, size: 28, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 8),

          // 2. Имя и специализация
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                master.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              Text(
                master.position,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.primaryBlack,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // Вертикальный разделитель (опционально, для стиля)
          Container(height: 20, width: 1, color: AppColors.lightBorder),
          const SizedBox(width: 12),

          // 3. Короткое описание (Опыт/Звание)
          Expanded(
            child: Text(
              master.description,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.primaryBlack.withValues(alpha: 0.5),
                fontStyle: FontStyle.italic,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
