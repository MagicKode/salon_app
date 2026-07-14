import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class SpecialistDescription extends StatelessWidget {
  final String description;

  const SpecialistDescription({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        description,
        style: TextStyle(
          fontSize: 12,
          color: AppColors.primaryBlack.withAlpha(128),
          fontStyle: FontStyle.italic,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
