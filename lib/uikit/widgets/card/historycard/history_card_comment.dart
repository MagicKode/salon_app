import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.chat_bubble_outline, size: 14, color: AppColors.primaryGrey),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            comment,
            maxLines: isExpanded ? null : 1,
            overflow: isExpanded ? null : TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: AppColors.primaryBlack,
            ),
          ),
        ),
        if (canEdit) ...[
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onEdit,
            child: const Icon(Icons.edit, color: AppColors.primaryBlue, size: 18),
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
    return GestureDetector(
      onTap: onTap,
      child: const Row(
        children: [
          Icon(Icons.add_comment_outlined, size: 14, color: AppColors.primaryBlue),
          SizedBox(width: 6),
          Text(
            'Добавить комментарий',
            style: TextStyle(color: AppColors.primaryBlue, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
