import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/servicedetailscreen/sections/servicedescription/service_description_section.dart';
import 'package:salon_flutter/feature/core/servicedetailscreen/sections/serviceimageheader/service_image_header_section.dart';
import 'package:salon_flutter/feature/core/servicedetailscreen/sections/serviceinfo/service_info_section.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../uikit/colors/app_colors.dart';
import '../../../uikit/widgets/button/app_button.dart';
import '../bookingservicescreen/booking_service_screen.dart';
import 'domain/service_detail_data.dart';

class ServiceDetailBody extends StatelessWidget {
  final ServiceDetail service;
  final bool isMaster;

  const ServiceDetailBody({
    super.key,
    required this.service,
    required this.isMaster,
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
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingServiceScreen(),
                        ),
                      );
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
