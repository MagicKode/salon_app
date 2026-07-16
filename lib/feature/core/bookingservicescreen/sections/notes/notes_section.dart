import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../../config/theme/custom_colors.dart';

class NotesSection extends StatelessWidget {
  final TextEditingController? controller;

  const NotesSection({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.notesHeader,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller,
          maxLines: 4,
          style: TextStyle(
            fontSize: 14,
            color: colors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: AppStrings.notesHint,
            hintStyle: TextStyle(
              color: colors.textHint,
              fontSize: 14,
            ),
            filled: true,
            fillColor: colors.surfaceInput,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }
}
