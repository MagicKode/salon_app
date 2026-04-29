import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

class NotesSection extends StatelessWidget {
  final TextEditingController? controller;

  const NotesSection({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final Color fieldColor = Colors.grey.shade100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.notesHeader,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller,
          maxLines: 4,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: AppStrings.notesHint,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            filled: true,
            fillColor: fieldColor,
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
