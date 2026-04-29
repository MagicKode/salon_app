import 'package:flutter/material.dart';

import '../../../../uikit/strings/app_strings.dart';
import '../../../../uikit/widgets/app_button.dart';

class BookingBottomBar extends StatelessWidget {
  const BookingBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15)],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(AppStrings.totalPrice, style: TextStyle(color: Colors.grey, fontSize: 14)),
              Text("30 ${AppStrings.currency}",
                  style: const TextStyle(color: Color(0xFF1D4D4F), fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: AppButton(
              text: AppStrings.bookNow,
              onPressed: () => _showSuccessDialog(context),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.bookingSuccessTitle),
        content: const Text(AppStrings.bookingSuccessSub),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
        ],
      ),
    );
  }
}
