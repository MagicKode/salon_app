import 'package:flutter/cupertino.dart';

import '../../../feature/core/catalogscreen/domain/bottom_bar_item_data.dart';
import '../../colors/app_colors.dart';

class SelectedBottomBarRow extends StatelessWidget {
  final BottomBarItemData item;

  const SelectedBottomBarRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryBlack,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${item.price.toStringAsFixed(0)} BYN',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryBlack,
            ),
          ),
        ],
      ),
    );
  }
}