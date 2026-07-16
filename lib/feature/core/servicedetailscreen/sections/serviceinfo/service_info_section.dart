import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/servicedetailscreen/domain/service_detail_data.dart';

import '../../../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов

class ServiceInfoSection extends StatelessWidget {
  final ServiceDetail service;

  const ServiceInfoSection({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              size: 18,
              color: colors.textSecondary, // ✅ динамический серый
            ),
            const SizedBox(width: 6),
            Text(
              service.duration,
              style: TextStyle(
                fontSize: 14,
                color: colors.textSecondary, // ✅ динамический серый
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: colors.primaryBlue.withOpacity(0.1),
            // ✅ динамический синий с прозрачностью
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            service.price,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colors.primaryBlue, // ✅ динамический синий
            ),
          ),
        ),
      ],
    );
  }
}
