import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import '../../../../../config/theme/custom_colors.dart';
import '../../../../../uikit/colors/app_colors.dart';
import '../../../../../uikit/strings/app_strings.dart';

class DescriptionSection extends StatelessWidget {
  final String description;

  const DescriptionSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 4, 24, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.sectionAbout,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),

            const SizedBox(height: 8),

            ExpandableText(
              AppStrings.aboutFullDescription,
              expandText: AppStrings.moreDetails,
              collapseText: AppStrings.hideDetails,
              maxLines: 3,
              linkColor: colors.primaryBlueLight,
              linkStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: colors.primaryBlueLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
