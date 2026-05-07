import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../../../../../uikit/strings/app_strings.dart';
import '../../../../../uikit/widgets/buttons/app_button.dart';

class BookingBottomBar extends StatelessWidget {
  final double totalPrice;
  final VoidCallback onTap;

  const BookingBottomBar({
    super.key,
    required this.totalPrice,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 10),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.totalPrice,
                style: const TextStyle(color: AppColors.primaryGrey, fontSize: 14),
              ),
              Text(
                '${totalPrice.toStringAsFixed(0)} ${AppStrings.currency}',
                style: const TextStyle(
                  color: AppColors.primaryBlue,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: AppButton(
              text: AppStrings.bookNow,
              onPressed: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
