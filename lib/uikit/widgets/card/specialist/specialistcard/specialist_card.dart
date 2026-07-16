import 'package:flutter/material.dart';

import '../../../../../config/theme/custom_colors.dart';
import '../../../../../feature/core/homepagescreen/sections/specialists/domain/master.dart';
import '../specialist_avatar.dart';
import '../specialist_description.dart';
import '../specialist_info.dart';

class SpecialistCard extends StatelessWidget {
  final Master master;

  const SpecialistCard({super.key, required this.master});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceCard, // ✅ динамический фон карточки
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SpecialistAvatar(imageUrl: master.imageUrl),
          const SizedBox(width: 8),
          SpecialistInfo(name: master.name, position: master.position),
          const SizedBox(width: 12),
          Container(
            height: 20,
            width: 1,
            color: colors.divider, // ✅ динамическая граница
          ),
          const SizedBox(width: 12),
          SpecialistDescription(description: master.description),
        ],
      ),
    );
  }
}
