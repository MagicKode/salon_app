import 'package:flutter/material.dart';

import '../../../../../uikit/colors/app_colors.dart';
import '../../../../../uikit/strings/app_strings.dart';
import '../../domain/feedback_item.dart';
import 'feedback_card.dart';
import 'leave_feedback_bottom_sheet.dart';
import 'rating_summary_card.dart';

class FeedbackSection extends StatelessWidget {
  final List<FeedbackItem> feedbacks;
  final bool isMaster;

  const FeedbackSection({
    super.key,
    required this.feedbacks,
    this.isMaster = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Заголовок
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            AppStrings.sectionFeedback,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(height: 10),

        // 1. Большая карточка с общей оценкой (как на скрине)
        const RatingSummaryCard(),

        // 2. Строка "Напишите отзыв" вместо кнопки
        if (!isMaster)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => _showLeaveFeedbackSheet(context),
                  child: const Text(
                    AppStrings.leaveFeedback,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryBlue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(height: 20),

        // 3. Горизонтальный список отзывов
        SizedBox(
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              return FeedbackCard(item: feedbacks[index]);
            },
          ),
        ),
      ],
    );
  }

  void _showLeaveFeedbackSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LeaveFeedbackBottomSheet(),
    );
  }
}
