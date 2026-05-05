import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/servicedetailscreen/domain/service_detail_data.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class ServiceInfoSection extends StatelessWidget {
  final ServiceDetail service;

  const ServiceInfoSection({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              size: 18,
              color: AppColors.primaryGrey,
            ),
            const SizedBox(width: 6),
            Text(
              service.duration,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primaryGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            service.price,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
        ),
      ],
    );
  }
}
