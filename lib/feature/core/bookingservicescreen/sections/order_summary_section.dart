import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

class OrderSummarySection extends StatelessWidget {
  final List<String> services;

  const OrderSummarySection({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.orderSummaryTitle,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              ...services.map(
                (service) =>
                    _buildOrderItem(service, "30 ${AppStrings.currency}"),
              ),
              const Divider(height: 24),
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.add, size: 18, color: Color(0xFF1D4D4F)),
                label: const Text(
                  AppStrings.addMoreServices,
                  style: TextStyle(
                    color: Color(0xFF1D4D4F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItem(String title, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
