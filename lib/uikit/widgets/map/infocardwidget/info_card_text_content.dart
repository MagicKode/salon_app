import 'package:flutter/material.dart';
import '../../../../feature/core/nearbymapscreen/domain/location_model.dart';
import '../../../colors/app_colors.dart';

class InfoCardTextContent extends StatelessWidget {
  final LocationModel shopLocation;

  const InfoCardTextContent({super.key, required this.shopLocation});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Адрес крупно
        Text(
          shopLocation.address,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.primaryWhite,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        // Подсказка или расстояние
        Text(
          shopLocation.distanceInKm != null
              ? '${shopLocation.formattedDistance} от вас'
              : 'Мы находимся здесь',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.primaryWhite.withValues(alpha: 0.9),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
