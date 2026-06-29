import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import 'package:salon_flutter/uikit/widgets/button/app_button.dart';

import 'bloc/review_bloc.dart';
import 'bloc/review_event.dart';

class LeaveFeedbackBottomSheet extends StatefulWidget {
  final int masterId;
  final ReviewBloc reviewBloc;
  final String clientName;

  const LeaveFeedbackBottomSheet({
    super.key,
    required this.masterId,
    required this.reviewBloc,
    required this.clientName,
  });

  @override
  State<LeaveFeedbackBottomSheet> createState() =>
      _LeaveFeedbackBottomSheetState();
}

class _LeaveFeedbackBottomSheetState extends State<LeaveFeedbackBottomSheet> {
  int _rating = 5;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Divider(thickness: 4, indent: 140, endIndent: 140),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              AppStrings.leaveFeedback,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // Звёзды рейтинга
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: AppColors.starsYellow,
                  size: 40,
                ),
                onPressed: () {
                  setState(() => _rating = index + 1);
                },
              );
            }),
          ),

          const SizedBox(height: 16),

          // Поле комментария
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _commentController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: AppStrings.writeYourFeedback,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                filled: true,
                fillColor: AppColors.primaryBackgroundColor,
              ),
            ),
          ),

          const Spacer(), // Прижмет кнопку к низу экрана

          Padding(
            padding: const EdgeInsets.all(20),
            child: AppButton(
              text: AppStrings.sendFeedback,
              onPressed: () {
                widget.reviewBloc.add(
                  ReviewCreateRequested(
                    masterId: widget.masterId,
                    rating: _rating,
                    clientName: widget.clientName,
                    text: _commentController.text,
                  ),
                );

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(AppStrings.thanksForYourFeedback),
                    backgroundColor: AppColors.primaryBlue,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
