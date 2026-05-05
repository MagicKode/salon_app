import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import '../../domain/home_models.dart';

class FeedbackCard extends StatelessWidget {
  final FeedbackItem item;

  const FeedbackCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 12, bottom: 8, top: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.boxDecorationColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.userName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                item.date,
                style: TextStyle(color: AppColors.primaryGrey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Звёзды
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < item.rating ? Icons.star : Icons.star_border,
                color: AppColors.starsYellow,
                size: 18,
              );
            }),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: Text(
              item.comment,
              style: const TextStyle(fontSize: 14, color: AppColors.primaryBlack),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
