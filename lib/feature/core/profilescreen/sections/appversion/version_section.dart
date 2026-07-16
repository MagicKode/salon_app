import 'package:flutter/material.dart';

import '../../../../../config/theme/custom_colors.dart';
import '../../domain/entities/app_version_entity.dart';

class VersionSection extends StatelessWidget {
  final AppVersionEntity versionInfo;

  const VersionSection({super.key, required this.versionInfo});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Text(
          versionInfo.displayVersion,
          style: TextStyle(
            color: colors.textHint, // ✅ динамический серый для версии
            fontSize: 12,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
