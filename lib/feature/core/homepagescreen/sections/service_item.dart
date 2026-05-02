import 'package:flutter/material.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../servicedetailscreen/sevice_detail_screen.dart';
import '../domain/home_models.dart';

class ServiceItem extends StatelessWidget {
  final ServiceCategory category;

  const ServiceItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => ServiceDetailScreen(category: category),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: category.backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(category.icon, color: category.iconColor, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            category.title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryBlue,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
