import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/domain/add_service_data.dart';

import '../../../config/theme/custom_colors.dart';
import '../../strings/app_strings.dart';

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
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              service.name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: colors.textPrimary, // ✅ динамический чёрный/белый
              ),
            ),
          ),
          Text(
            '${service.price.toStringAsFixed(0)} ${AppStrings.currency}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colors.textPrimary, // ✅ динамический чёрный/белый
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(
              Icons.close,
              size: 18,
              color: colors.textSecondary, // ✅ динамический серый
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
