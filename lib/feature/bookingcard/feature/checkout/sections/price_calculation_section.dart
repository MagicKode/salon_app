import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class PriceCalculationSection extends StatelessWidget {
  const PriceCalculationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        PriceDetailsRow(label: "Стрижка", value: "50 BYN"),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Divider(color: Colors.white, thickness: 1),
        ),
        PriceDetailsRow(
          label: "Итого",
          value: "50 BYN",
          isBold: true,
          fontSize: 18,
        ),
      ],
    );
  }
}

class PriceDetailsRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;
  final double fontSize;

  const PriceDetailsRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontWeight: isBold ? FontWeight.bold : FontWeight.bold,
      fontSize: fontSize,
      color: AppColors.primaryBlue,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style.copyWith(color: valueColor ?? style.color)),
        ],
      ),
    );
  }
}
