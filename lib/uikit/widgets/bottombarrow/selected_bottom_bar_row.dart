import 'package:flutter/material.dart';

import '../../../config/theme/custom_colors.dart';
import '../../../feature/core/catalogscreen/domain/bottom_bar_item_data.dart';

class SelectedBottomBarRow extends StatelessWidget {
  final BottomBarItemData item;

  const SelectedBottomBarRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

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
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: colors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${item.price.toStringAsFixed(0)} BYN',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
