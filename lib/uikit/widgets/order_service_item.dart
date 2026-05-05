import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/domain/add_service_data.dart';
import '../colors/app_colors.dart';
import '../strings/app_strings.dart';

class OrderServiceItem extends StatelessWidget {
  final AddServiceData service;
  final Function(AddServiceData) onRemove;

  const OrderServiceItem({
    super.key,
    required this.service,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              service.name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            '${service.price.toStringAsFixed(0)} ${AppStrings.currency}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(
              Icons.close,
              size: 18,
              color: AppColors.primaryGrey,
            ),
            onPressed: () => onRemove(service),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
