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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primaryBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Большой рейтинг
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      averageRating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < averageRating.floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: AppColors.starsYellow,
                          size: 16,
                        );
                      }),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "$totalReviews ${AppStrings.reviews}",
                      style: TextStyle(
                        color: AppColors.primaryGrey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // Распределение оценок
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(5, (index) {
                    final rating = 5 - index;
                    final percentage = rating == 5 ? 0.85 : (rating == 4 ? 0.1 : 0.02);

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          Text(
                            "$rating",
                            style: const TextStyle(fontSize: 13),
                          ),

                          const SizedBox(width: 6),

                          Icon(Icons.star, color: AppColors.starsYellow, size: 14),

                          const SizedBox(width: 8),

                          SizedBox(
                            width: 200,
                            child: LinearProgressIndicator(
                              value: percentage,
                              backgroundColor: AppColors.primaryGrey,
                              color: AppColors.primaryGreen,
                              minHeight: 6,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
