import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../../uikit/colors/app_colors.dart';

class CheckoutBottomActions extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CheckoutBottomActions({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                AppStrings.bookingConfirmation,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onCancel,
            child: Text(
              AppStrings.cancelAndLeave,
              style: TextStyle(
                color: AppColors.primaryRed,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
