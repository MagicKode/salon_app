import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../../../uikit/widgets/app_button.dart';

class MenuBottomBar extends StatelessWidget {
  const MenuBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Блок цены
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Total (1 Service)",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "30 BYN",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ],
            ),
          ),
          // Кнопка чата (уменьшили и сместили)
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chat_outlined, color: AppColors.primaryBlue),
            style: IconButton.styleFrom(
              side: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton(text: AppStrings.bookNow, onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
