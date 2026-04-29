import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../../../../uikit/strings/app_strings.dart';
import '../domain/home_models.dart';

class FeedbackSection extends StatelessWidget {
  final List<FeedbackItem> feedbacks;

  const FeedbackSection({super.key, required this.feedbacks});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            AppStrings.sectionFeedback,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160, // Высота секции отзывов
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              return _FeedbackCard(item: feedbacks[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _FeedbackCard extends StatelessWidget {
  final FeedbackItem item;

  const _FeedbackCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280, // Оптимальная ширина для отзывов
      margin: const EdgeInsets.only(right: 12, bottom: 8, top: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Ряд со звездами
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < item.rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 18,
              );
            }),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              item.comment,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
