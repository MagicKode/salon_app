import 'package:flutter/material.dart';

import '../../../../feature/core/nearbymapscreen/domain/location_model.dart';
import '../../../colors/app_colors.dart';

class InfoCardTextContent extends StatelessWidget {
  final LocationModel shopLocation;

  const InfoCardTextContent({super.key, required this.shopLocation});

  @override
  Widget build(BuildContext context) {
    final bool hasDistance = shopLocation.distanceInKm != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Первая строка: Расстояние
        Text(
          hasDistance
              ? 'В ${shopLocation.formattedDistance} от вас'
              : 'Считаем путь...',
          style: const TextStyle(
            color: AppColors.primaryWhite,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),

        const SizedBox(height: 4),

        // Вторая строка: Адрес
        Text(
          shopLocation.address,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          // Обрезаем, если адрес слишком длинный
          style: TextStyle(
            color: AppColors.primaryWhite.withOpacity(0.9),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
