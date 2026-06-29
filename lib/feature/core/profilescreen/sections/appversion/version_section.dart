import 'package:flutter/material.dart';
import '../../../../../uikit/colors/app_colors.dart';
import '../../domain/entities/app_version_entity.dart';

class VersionSection extends StatelessWidget {
  final AppVersionEntity versionInfo;

  const VersionSection({
    super.key,
    required this.versionInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Text(
          versionInfo.displayVersion,
          style: const TextStyle(
            color: AppColors.primaryGrey,
            fontSize: 12,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
