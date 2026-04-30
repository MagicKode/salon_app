import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import 'booking_info_grid.dart';
import 'price_calculation_section.dart';

class BookingSummaryCard extends StatelessWidget {
  const BookingSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.boxDecorationColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BookingInfoGrid(),
          const SizedBox(height: 20),
          const Divider(color: Colors.white, thickness: 1.5),
          const SizedBox(height: 20),
          const Text(
            "Услуги",
            style: TextStyle(
              color: AppColors.primaryBlack,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          const PriceCalculationSection(),
        ],
      ),
    );
  }
}
