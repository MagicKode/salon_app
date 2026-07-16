import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../../config/theme/custom_colors.dart';

class HomeSearchBar extends StatelessWidget {
  final VoidCallback? onTap;

  const HomeSearchBar({super.key, this.onTap,});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: colors.surfaceInput,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                readOnly: true,
                onTap: onTap,
                style: TextStyle(
                  fontSize: 15,
                  color: colors.textSecondary,
                ),
                decoration: InputDecoration(
                  hintText: AppStrings.hintServiceMasterSearch,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: colors.textHint,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20,
                    color: colors.primaryBlue,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
