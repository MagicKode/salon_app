import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import '../../../../../uikit/strings/app_strings.dart';

class RatingSummaryCard extends StatelessWidget {
  final double averageRating;
  final int totalReviews;

  const RatingSummaryCard({
    super.key,
    this.averageRating = 4.4,
    this.totalReviews = 907,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      // Меньше внешний отступ
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Левая часть
            SizedBox(
              width: 70,
              child: Column(
                children: [
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < averageRating.floor()
                            ? Icons.star
                            : Icons.star_border,
                        color: AppColors.starsYellow,
                        size: 12,
                      ),
                    ),
                  ),
                  Text(
                    "$totalReviews отзывов",
                    style: TextStyle(
                      color: AppColors.primaryGrey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 6),

            // Разделитель (опционально, добавит аккуратности)
            Container(
              width: 1,
              height: 40,
              color: Colors.black.withOpacity(0.05),
            ),

            const SizedBox(width: 12),
            // Правая часть (прогресс-бары)
            Expanded(
              child: Column(
                children: List.generate(5, (index) {
                  final rating = 5 - index;
                  final percentage =
                      rating == 5 ? 0.85 : (rating == 4 ? 0.15 : 0.05);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    // Плотная верстка
                    child: Row(
                      children: [
                        Text("$rating", style: const TextStyle(fontSize: 10)),
                        const SizedBox(width: 2),
                        Icon(Icons.star, color: AppColors.starsYellow, size: 8),
                        const SizedBox(width: 6),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: percentage,
                            backgroundColor: AppColors.primaryGrey.withOpacity(
                              0.3,
                            ),
                            color: AppColors.primaryGreen,
                            minHeight: 2.5,
                            // Тонкие полоски
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
