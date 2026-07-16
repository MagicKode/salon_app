import 'package:flutter/material.dart';

import '../../../config/theme/custom_colors.dart';
import '../../strings/app_strings.dart';

class ExpandableNote extends StatefulWidget {
  final String note;
  final bool isInitialExpanded;

  const ExpandableNote({
    super.key,
    required this.note,
    this.isInitialExpanded = false,
  });

  @override
  State<ExpandableNote> createState() => _ExpandableNoteState();
}

class _ExpandableNoteState extends State<ExpandableNote> {
  late bool _isExpanded = widget.isInitialExpanded;

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors.surfaceCard, // ✅ динамический фон
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.edit_note,
                  size: 18,
                  color: colors.textSecondary, // ✅ динамический серый
                ),
                const SizedBox(width: 8),
                Text(
                  AppStrings.notesHeader,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: colors.textSecondary, // ✅ динамический серый
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.note,
              maxLines: _isExpanded ? null : 1,
              overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: colors.textPrimary, // ✅ динамический чёрный/белый
              ),
            ),
          ],
        ),
      ),
    );
  }
}
