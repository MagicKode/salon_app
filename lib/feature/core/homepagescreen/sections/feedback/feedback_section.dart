import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/feedback/reviewmodel/review_model.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/feedback/reviewmodel/review_stats_model.dart';

import '../../../../../config/theme/custom_colors.dart';
import '../../../../../uikit/colors/app_colors.dart';
import '../../../../../uikit/strings/app_strings.dart';
import '../../../../../uikit/widgets/card/feedback/feedback_card.dart';
import '../../../../../uikit/widgets/card/feedback/rating_summary_card.dart';
import '../../../../auth/authblock/bloc/auth_block.dart';
import '../../../../auth/authblock/bloc/auth_state.dart';
import 'bloc/review_bloc.dart';
import 'leave_feedback_bottom_sheet.dart';

class FeedbackSection extends StatelessWidget {
  final ReviewStatsModel stats;
  final List<ReviewModel> reviews;
  final bool isMaster;

  const FeedbackSection({
    super.key,
    required this.stats,
    required this.reviews,
    this.isMaster = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

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
        RatingSummaryCard(stats: stats),

        // 2. Строка "Напишите отзыв" вместо кнопки
        if (!isMaster)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => _showLeaveFeedbackSheet(context),
                  child: Text(
                    AppStrings.leaveFeedback,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: colors.primaryBlueLight,
                    ),
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(height: 20),

        // 3. Горизонтальный список отзывов
        if (reviews.isNotEmpty) ...[
          const SizedBox(height: 20),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return FeedbackCard(review: reviews[index]);
              },
            ),
          ),
        ],
      ],
    );
  }

  void _showLeaveFeedbackSheet(BuildContext context) {
    // 1. Читаем текущее состояние AuthBloc
    final authState = context.read<AuthBloc>().state;

    String clientName = "Клиент"; // Дефолтное значение

    if (authState is AuthSuccess) {
      clientName = authState.user.name;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LeaveFeedbackBottomSheet(
        masterId: 1, // Передаем ID мастера (в будущем бери из модели салона/мастера)
        reviewBloc: BlocProvider.of<ReviewBloc>(context),
        clientName: clientName, // <-- Передаем вытащенное имя в шторку!
      ),
    );
  }
}
