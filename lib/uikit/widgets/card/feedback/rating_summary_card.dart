import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../../../../feature/core/homepagescreen/sections/feedback/reviewmodel/review_stats_model.dart';

class RatingSummaryCard extends StatelessWidget {
  final ReviewStatsModel stats;

  const RatingSummaryCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      // Меньше внешний отступ
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withValues(alpha: 0.1),
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
                    stats.averageRating.toStringAsFixed(1),
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
                        index < stats.averageRating.floor()
                            ? Icons.star
                            : Icons.star_border,
                        color: AppColors.starsYellow,
                        size: 12,
                      ),
                    ),
                  ),
                  Text(
                    "${stats.totalReviews} отзывов",
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
              color: Colors.black.withValues(alpha: 0.05),
            ),

            const SizedBox(width: 12),

            // Правая часть (прогресс-бары)
            Expanded(
              child: Column(
                children: List.generate(5, (index) {
                  final rating = 5 - index;

                  // Считаем количество отзывов для текущей оценки
                  int currentStarCount = 0;
                  switch (rating) {
                    case 5:
                      currentStarCount = stats.star5Count;
                      break;
                    case 4:
                      currentStarCount = stats.star4Count;
                      break;
                    case 3:
                      currentStarCount = stats.star3Count;
                      break;
                    case 2:
                      currentStarCount = stats.star2Count;
                      break;
                    case 1:
                      currentStarCount = stats.star1Count;
                      break;
                  }

                  // Вычисляем процент заполнения полоски (защита от деления на 0)
                  final double percentage =
                      stats.totalReviews > 0
                          ? currentStarCount / stats.totalReviews
                          : 0.0;

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
                            backgroundColor: AppColors.primaryGrey.withValues(
                              alpha: 0.3,
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
