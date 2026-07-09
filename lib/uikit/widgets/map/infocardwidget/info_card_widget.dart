import 'package:flutter/material.dart';

import '../../../../feature/core/nearbymapscreen/domain/location_model.dart';
import '../../../colors/app_colors.dart';
import 'info_card_text_content.dart';
import 'info_card_transport_icon.dart';

class InfoCardWidget extends StatelessWidget {
  final LocationModel shopLocation;

  const InfoCardWidget({super.key, required this.shopLocation});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppColors.primaryWhite.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlack.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          const InfoCardTransportIcon(),
          const SizedBox(width: 16),
          Expanded(child: InfoCardTextContent(shopLocation: shopLocation)),
        ],
      ),
    );
  }
}
