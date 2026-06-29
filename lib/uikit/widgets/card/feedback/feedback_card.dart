import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../../../../feature/core/homepagescreen/sections/feedback/reviewmodel/review_model.dart';

class FeedbackCard extends StatelessWidget {
  final ReviewModel review;

  const FeedbackCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    // Простейшее форматирование даты (можно заменить на intl / timeago)
    final String formattedDate =
        "${review.createdAt.day}.${review.createdAt.month}.${review.createdAt.year}";

    return InkWell(
      onTap: () => _showFullReview(context, formattedDate),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 12, bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withValues(alpha: 0.15),
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
                  review.clientName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  formattedDate,
                  style: TextStyle(color: AppColors.primaryGrey, fontSize: 10),
                ),
              ],
            ),

            const SizedBox(height: 2),

            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < review.rating ? Icons.star : Icons.star_border,
                  color: AppColors.starsYellow,
                  size: 12,
                ),
              ),
            ),

            const SizedBox(height: 4),

            Text(
              review.text.isNotEmpty ? review.text : "Без комментария",
              style: const TextStyle(fontSize: 12, height: 1.2),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // Метод, который открывает шторку
  void _showFullReview(BuildContext context, String date) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.primaryWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(review.clientName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(date, style: TextStyle(color: AppColors.primaryGrey)),
            const SizedBox(height: 16),
            Text(
              review.text.isNotEmpty ? review.text : "Без комментария",
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Закрыть"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
