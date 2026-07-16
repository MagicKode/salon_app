import 'package:flutter/material.dart';

import '../../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов
import '../../../../feature/core/homepagescreen/sections/feedback/reviewmodel/review_stats_model.dart';

class RatingSummaryCard extends StatelessWidget {
  final ReviewStatsModel stats;

  const RatingSummaryCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: colors.primaryBlue.withOpacity(0.1), // ✅ динамический синий с прозрачностью
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
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                      color: colors.textPrimary, // ✅ динамический чёрный/белый
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
                        color: colors.ratingStar, // ✅ динамический жёлтый
                        size: 12,
                      ),
                    ),
                  ),
                  Text(
                    "${stats.totalReviews} отзывов",
                    style: TextStyle(
                      color: colors.textSecondary, // ✅ динамический серый
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 6),

            // Разделитель
            Container(
              width: 1,
              height: 40,
              color: colors.divider, // ✅ динамическая граница
            ),

            const SizedBox(width: 12),

            // Правая часть (прогресс-бары)
            Expanded(
              child: Column(
                children: List.generate(5, (index) {
                  final rating = 5 - index;

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

                  final double percentage =
                  stats.totalReviews > 0
                      ? currentStarCount / stats.totalReviews
                      : 0.0;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Row(
                      children: [
                        Text("$rating", style: const TextStyle(fontSize: 10)),
                        const SizedBox(width: 2),
                        Icon(
                          Icons.star,
                          color: colors.ratingStar, // ✅ динамический жёлтый
                          size: 8,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: percentage,
                            backgroundColor: colors.divider, // ✅ динамическая граница
                            color: colors.statusSuccess, // ✅ динамический зелёный
                            minHeight: 2.5,
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
