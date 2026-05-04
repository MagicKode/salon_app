import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/checkout/checkout_body.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
        decoration: const BoxDecoration(
          color: AppColors.primaryWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.primaryGrey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const Flexible(
              child: SingleChildScrollView(
                child: CheckoutBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
