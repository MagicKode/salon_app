import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/servicesgrid/service_item.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../../uikit/colors/app_colors.dart';
import '../../../servicedetailscreen/sevice_detail_screen.dart';
import '../../domain/home_models.dart';

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
          children: [
            const SizedBox(height: 12),
            // Полоска-индикатор закрытия
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.primaryBlackShadow.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SizedBox(
                // width: MediaQuery.of(context).size.width,
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
    // Высота секции должна вмещать 2 картинки + отступы
    // Если одна картинка ~160px, то ставим около 340-350px
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: Text(
            AppStrings.ourServices,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 240,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 элемента в высоту (в колонке)
              mainAxisSpacing: 10, // Отступ между колонками
              crossAxisSpacing: 10, // Отступ между рядами
              childAspectRatio: 0.75, // Квадратные плитки
            ),
            itemCount: ServiceData.categories.length,
            itemBuilder: (context, index) {
              final category = ServiceData.categories[index];
              return GestureDetector(
                onTap: () => _showServiceDetails(context, category),
                child: ServiceItem(category: category),
              );
            },
          ),
        ),
      ],
    );
  }
}
