import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/service_item.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../servicedetailscreen/sevice_detail_screen.dart';
import '../domain/home_models.dart';

class ServiceGridSection extends StatelessWidget {
  const ServiceGridSection({super.key});

  void _showServiceDetails(BuildContext context, ServiceCategory category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.primaryWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.primaryBlackShadow,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ServiceDetailScreen(category: category),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: ServiceData.categories.length,
      itemBuilder: (context, index) {
        final category = ServiceData.categories[index];
        return GestureDetector(
          onTap: () => _showServiceDetails(context, category),
          child: ServiceItem(category: category),
        );
      },
    );
  }
}
