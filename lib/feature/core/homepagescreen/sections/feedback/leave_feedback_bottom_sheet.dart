import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import 'package:salon_flutter/uikit/widgets/button/app_button.dart';

import '../../../../../config/theme/custom_colors.dart';
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
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: colors.backgroundPrimary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
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
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
          ),

          // Звёзды рейтинга
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: colors.ratingStar,
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
                hintStyle: TextStyle(color: colors.textHint),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: colors.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: colors.borderLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: colors.primaryBlue, width: 2),
                ),
                filled: true,
                fillColor: colors.surfaceInput,
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
                  SnackBar(
                    content: const Text(AppStrings.thanksForYourFeedback),
                    backgroundColor: colors.primaryBlue,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
