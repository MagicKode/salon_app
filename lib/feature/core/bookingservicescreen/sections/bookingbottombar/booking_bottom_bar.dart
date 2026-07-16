import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../../../../../config/theme/custom_colors.dart';
import '../../../../../uikit/strings/app_strings.dart';
import '../../../../../uikit/widgets/button/app_button.dart';

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
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 10),
      decoration: BoxDecoration(
        color: colors.backgroundPrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
                style: TextStyle(color: colors.textSecondary, fontSize: 14),
              ),
              Text(
                '${totalPrice.toStringAsFixed(0)} ${AppStrings.currency}',
                style: TextStyle(
                  color: colors.primaryBlueLight,
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
