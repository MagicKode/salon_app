import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../../domain/feedback_item.dart';

class FeedbackCard extends StatelessWidget {
  final FeedbackItem item;

  const FeedbackCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.userName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Text(
                item.date,
                style: TextStyle(color: AppColors.primaryGrey, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: List.generate(5, (index) => Icon(
              index < item.rating ? Icons.star : Icons.star_border,
              color: AppColors.starsYellow,
              size: 12,
            )),
          ),
          const SizedBox(height: 4),
          Text(
            item.comment,
            style: const TextStyle(fontSize: 12, height: 1.2),
            maxLines: 2, // Ограничиваем текст, чтобы карточки были одной высоты
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
