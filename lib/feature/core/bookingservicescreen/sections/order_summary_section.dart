import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/domain/add_service_data.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../../../uikit/strings/app_strings.dart';
import '../../../../uikit/widgets/order_service_item.dart';

class OrderSummarySection extends StatelessWidget {
  final List<AddServiceData> selectedServices;
  final VoidCallback onAddMoreServices;
  final Function(AddServiceData) onRemoveService;

  const OrderSummarySection({
    super.key,
    required this.selectedServices,
    required this.onAddMoreServices,
    required this.onRemoveService,
  });

  @override
  Widget build(BuildContext context) {
    final totalPrice = selectedServices.fold(
      0.0,
          (sum, service) => sum + service.price,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.orderSummaryTitle,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryBackgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.lightBorder),
          ),
          child: Column(
            children: [
              if (selectedServices.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    AppStrings.serviceListIsEmpty,
                    style: TextStyle(color: AppColors.primaryGrey),
                  ),
                )
              else
                ...selectedServices.map(
                      (service) => OrderServiceItem(
                    service: service,
                    onRemove: onRemoveService,
                  ),
                ),

              const Divider(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(AppStrings.finalSum, style: TextStyle(fontSize: 16)),
                  Text(
                    '${totalPrice.toStringAsFixed(0)} ${AppStrings.currency}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),

              const Divider(height: 12),

              TextButton.icon(
                onPressed: onAddMoreServices,
                icon: const Icon(
                  Icons.add,
                  size: 18,
                  color: AppColors.primaryBlue,
                ),
                label: const Text(
                  AppStrings.addMoreServices,
                  style: TextStyle(
                    color: AppColors.primaryBlue,
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
}
