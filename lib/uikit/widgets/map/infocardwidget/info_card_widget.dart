import 'package:flutter/material.dart';

import '../../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов
import 'info_card_text_content.dart';
import 'info_card_transport_icon.dart';

class InfoCardWidget extends StatelessWidget {
  final String address;

  const InfoCardWidget({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: colors.primaryBlue.withOpacity(0.5),
        // ✅ динамический синий с прозрачностью
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: colors.textOnPrimary.withOpacity(
            0.15,
          ), // ✅ контрастный белый с прозрачностью
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow, // ✅ динамическая тень
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          const InfoCardTransportIcon(),
          const SizedBox(width: 16),
          Expanded(child: InfoCardTextContent(address: address)),
        ],
      ),
    );
  }
}
