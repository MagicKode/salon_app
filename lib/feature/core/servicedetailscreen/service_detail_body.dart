import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/servicedetailscreen/sections/service_description_section.dart';
import 'package:salon_flutter/feature/core/servicedetailscreen/sections/service_image_header_section.dart';
import 'package:salon_flutter/feature/core/servicedetailscreen/sections/service_info_section.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import 'package:salon_flutter/uikit/widgets/app_button.dart';
import 'domain/service_detail_data.dart';

class ServiceDetailBody extends StatelessWidget {
  // Данные теперь приходят из константного класса
  final ServiceDetail service;

  const ServiceDetailBody({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: AppButton(
          text: AppStrings.bookNow,
          onPressed: () => _handleBooking(context),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          ServiceImageHeaderSection(
            title: service.title,
            imageUrl: service.imageUrl,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ServiceInfo(
                    duration: service.duration,
                    price: service.price,
                  ),
                  const Divider(height: 40),
                  ServiceDescriptionSection(
                    description: service.description,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleBooking(BuildContext context) {
    // Логика
  }
}
