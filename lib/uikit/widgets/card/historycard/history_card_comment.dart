import 'package:flutter/material.dart';

import '../../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов

class HistoryCardCommentRow extends StatelessWidget {
  final String comment;
  final bool canEdit;
  final bool isExpanded;
  final VoidCallback onEdit;

  const HistoryCardCommentRow({
    super.key,
    required this.comment,
    required this.canEdit,
    required this.isExpanded,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.chat_bubble_outline,
          size: 14,
          color: colors.textSecondary, // ✅ динамический серый
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            comment,
            maxLines: isExpanded ? null : 1,
            overflow: isExpanded ? null : TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: colors.textPrimary, // ✅ динамический чёрный/белый
            ),
          ),
        ),
        if (canEdit) ...[
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onEdit,
            child: Icon(
              Icons.edit,
              color: colors.primaryBlue, // ✅ динамический синий
              size: 18,
            ),
          ),
        ],
      ],
    );
  }
}

class HistoryCardAddCommentButton extends StatelessWidget {
  final VoidCallback onTap;

  const HistoryCardAddCommentButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            Icons.add_comment_outlined,
            size: 14,
            color: colors.primaryBlue, // ✅ динамический синий
          ),
          const SizedBox(width: 6),
          Text(
            'Добавить комментарий',
            style: TextStyle(
              color: colors.primaryBlue, // ✅ динамический синий
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
