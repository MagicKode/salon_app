import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/checkout/domain/booking_entity.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/domain/add_service_data.dart';

import '../../../../../uikit/colors/app_colors.dart';
import '../../../../../uikit/strings/app_strings.dart';
import '../../../../../uikit/widgets/order/order_service_item.dart';

class OrderSummarySection extends StatelessWidget {
  final List<AddServiceData> selectedServices;
  final VoidCallback onAddMoreServices;
  final Function(AddServiceData) onRemoveService;
  final String notes;


  const OrderSummarySection({
    super.key,
    required this.selectedServices,
    required this.onAddMoreServices,
    required this.onRemoveService,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    final totalPriceValue = selectedServices.totalPrice;
    final totalDurationValue = selectedServices.totalDuration;

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
            color: AppColors.primaryBackgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.lightBorder),
          ),
          child: Column(
            children: [

              // --- СПИСОК УСЛУГ ---
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

              const Divider(height: 24),

              // --- ИТОГО И ДЛИТЕЛЬНОСТЬ ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    AppStrings.finalSum,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      Text(
                        '${totalPriceValue.toStringAsFixed(0)} ${AppStrings.currency}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlack,
                        ),
                      ),

                      if (selectedServices.isNotEmpty)
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 14,
                              color: AppColors.primaryBlack,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "$totalDurationValue мин",
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),

              if (notes.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.boxDecorationColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        AppStrings.notesHeader,
                        style: TextStyle(fontSize: 12, color: AppColors.primaryGrey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notes,
                        style: const TextStyle(fontSize: 14, color: AppColors.primaryBlack),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 16),
              const Divider(height: 1),

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
