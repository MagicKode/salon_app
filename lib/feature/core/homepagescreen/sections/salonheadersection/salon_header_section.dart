import 'package:flutter/material.dart';

import '../../../../../config/theme/custom_colors.dart';
import '../../../../../uikit/strings/app_strings.dart';

class SalonHeaderSection extends StatelessWidget {
  final String name;
  final String address;
  final String workingHours;
  final VoidCallback? onLocationTap;

  const SalonHeaderSection({
    super.key,
    required this.name,
    required this.address,
    required this.workingHours,
    required this.onLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0), // Отступы для верха
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.ourAddress,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),

                // Строка с адресом
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: colors.primaryBlue,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        address,
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Строка с временем работы
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: colors.primaryBlue,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${AppStrings.workSchedule} $workingHours',
                      style: TextStyle(
                        fontSize: 14,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          GestureDetector(
            onTap: onLocationTap,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colors.surfaceCard,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.location_on_outlined,
                color: colors.primaryBlue,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
