import 'package:flutter/material.dart';
import 'price_details_row.dart';

class PriceCalculationSection extends StatelessWidget {
  final double totalPrice;

  const PriceCalculationSection({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PriceDetailsRow(label: "Женская стрижка", value: "${totalPrice.toStringAsFixed(0)} BYN"),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Divider(thickness: 1),
        ),
        PriceDetailsRow(
          label: "Итого",
          value: "${totalPrice.toStringAsFixed(0)} BYN",
          isTotal: true,
        ),
      ],
    );
  }
}
