import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../../../uikit/strings/app_strings.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.sectionAbout, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ExpandableText(
            AppStrings.aboutFullDescription,
            expandText: AppStrings.moreDetails,
            collapseText: AppStrings.hideDetails,
            maxLines: 3,
            linkColor: AppColors.primaryBlue,
          ),
        ],
      ),
    );
  }
}
