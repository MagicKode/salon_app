import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/servicedetailscreen/sections/servicedescription/service_description_section.dart';
import 'package:salon_flutter/feature/core/servicedetailscreen/sections/serviceimageheader/service_image_header_section.dart';
import 'package:salon_flutter/feature/core/servicedetailscreen/sections/serviceinfo/service_info_section.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../uikit/colors/app_colors.dart';
import '../../../uikit/widgets/button/app_button.dart';
import '../catalogscreen/domain/catalog_service.dart';
import 'domain/service_detail_data.dart';

class ServiceDetailBody extends StatelessWidget {
  final ServiceDetail service;
  final bool isMaster;
  final Function(CatalogService selectedService)? onServiceSelected;

  const ServiceDetailBody({
    super.key,
    required this.service,
    required this.isMaster,
    this.onServiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ServiceImageHeaderSection(service: service),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
            // Убрал лишний нижний паддинг
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ServiceInfoSection(service: service),
                const Divider(height: 24),
                ServiceDescriptionSection(description: service.description),

                if (!isMaster) ...[
                  const SizedBox(height: 24),
                  AppButton(
                    text: AppStrings.bookNow,
                    onPressed: () {
                      final double computedPrice = double.tryParse(
                        service.price.toString().replaceAll(RegExp(r'[^0-9.]'), ''),
                      ) ?? 0.0; // Если перевод не удался, ставим 0.0 по умолчанию

                      final selectedService = CatalogService(
                        id: service.title,
                        name: service.title, // Передаем название (например, "Мужская стрижка")
                        price: computedPrice, // Передаем цену (например, 30.0)
                        duration: '1 ч.',
                      );

                      // Закрываем шторку деталей и передаем выбранную услугу назад в HomePageBody
                      if (onServiceSelected != null) {
                        onServiceSelected!(selectedService);
                      } else {
                        // Фаллбэк на случай, если экран открыт не в модалке
                        Navigator.pop(context, selectedService);
                      }
                    },
                  ),
                ],
                SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
