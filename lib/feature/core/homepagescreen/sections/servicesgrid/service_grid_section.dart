import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/servicesgrid/service_item.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../../uikit/colors/app_colors.dart';
import '../../../catalogscreen/domain/catalog_service.dart';
import '../../../servicedetailscreen/domain/service_detail_data.dart';
import '../../../servicedetailscreen/service_detail_body.dart';
import '../../../servicedetailscreen/sevice_detail_screen.dart';
import '../../domain/home_models.dart';

class ServiceGridSection extends StatelessWidget {
  final bool isMaster;
  final Function(CatalogService service)? onQuickBookRequested;

  const ServiceGridSection({
    super.key,
    required this.isMaster,
    this.onQuickBookRequested,
  });

  Future<void> _showServiceDetails(BuildContext context, ServiceCategory category) async {
    // 1. Ищем данные детализации прямо здесь (код скопирован из твоего ServiceDetailScreen)
    final detail = ServiceDetailData.allDetails.firstWhere(
          (element) => element.title == category.title,
      orElse: () => ServiceDetailData.mensHaircut,
    );

    // 2. Открываем Body напрямую в модалке
    final CatalogService? result = await showModalBottomSheet<CatalogService>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ServiceDetailBody(
        service: detail,
        isMaster: isMaster,
      ),
    );

    if (result != null && context.mounted) {
      onQuickBookRequested?.call(result);
    }
  }

  @override
  Widget build(BuildContext context) {
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
