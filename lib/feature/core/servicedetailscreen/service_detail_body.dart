import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/servicedetailscreen/sections/service_description_section.dart';
import 'package:salon_flutter/feature/core/servicedetailscreen/sections/service_image_header_section.dart';
import 'package:salon_flutter/feature/core/servicedetailscreen/sections/service_info_section.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../uikit/colors/app_colors.dart';
import '../../../uikit/widgets/app_button.dart';
import 'domain/service_detail_data.dart';

class ServiceDetailBody extends StatelessWidget {
  final ServiceDetail service;

  const ServiceDetailBody({super.key, required this.service});

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
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ServiceInfoSection(service: service),
                    const Divider(height: 24),
                    ServiceDescriptionSection(description: service.description),
                    const SizedBox(height: 16),
                    AppButton(text: AppStrings.bookNow, onPressed: () {}),
                    SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
