import 'package:flutter/material.dart';

import '../../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов
import '../../../../feature/core/homepagescreen/sections/feedback/reviewmodel/review_model.dart';

class FeedbackCard extends StatelessWidget {
  final ReviewModel review;

  const FeedbackCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

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
          color: colors.primaryBlue.withOpacity(0.15),
          // ✅ динамический синий с прозрачностью
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: colors.textPrimary, // ✅ динамический чёрный/белый
                  ),
                ),
                Text(
                  formattedDate,
                  style: TextStyle(
                    color: colors.textSecondary, // ✅ динамический серый
                    fontSize: 10,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 2),

            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < review.rating ? Icons.star : Icons.star_border,
                  color: colors.ratingStar, // ✅ динамический жёлтый
                  size: 12,
                ),
              ),
            ),

            const SizedBox(height: 4),

            Text(
              review.text.isNotEmpty ? review.text : "Без комментария",
              style: TextStyle(
                fontSize: 12,
                height: 1.2,
                color: colors.textSecondary, // ✅ динамический серый
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _showFullReview(BuildContext context, String date) {
    // ✅ Получаем динамические цвета внутри метода
    final colors = Theme.of(context).extension<CustomColors>()!;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colors.backgroundPrimary, // ✅ динамический фон
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.clientName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(date, style: TextStyle(color: colors.textSecondary)),
                const SizedBox(height: 16),
                Text(
                  review.text.isNotEmpty ? review.text : "Без комментария",
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primaryBlue,
                      foregroundColor: colors.textOnPrimary,
                    ),
                    child: const Text("Закрыть"),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
