import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import 'price_details_row.dart';

class PriceCalculationSection extends StatelessWidget {
  final double totalPrice;

  const PriceCalculationSection({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: PriceDetailsRow(
        label: AppStrings.finalSum,
        value: "${totalPrice.toStringAsFixed(0)} BYN",
        isTotal: true,
      ),
    );
  }
}
