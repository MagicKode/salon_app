import 'package:flutter/material.dart';

import '../../colors/app_colors.dart';
import '../../strings/app_strings.dart';

class ExpandableNote extends StatefulWidget {
  final String note;

  const ExpandableNote({required this.note});

  @override
  State<ExpandableNote> createState() => _ExpandableNoteState();
}

class _ExpandableNoteState extends State<ExpandableNote> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.edit_note, size: 18, color: AppColors.primaryGrey),
                const SizedBox(width: 8),
                Text(
                  AppStrings.notesHeader,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.note,
              maxLines: _isExpanded ? null : 1,
              overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, color: AppColors.primaryBlack),
            ),
          ],
        ),
      ),
    );
  }
}
