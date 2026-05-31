import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

class HomeSearchBar extends StatelessWidget {
  final VoidCallback? onTap;

  const HomeSearchBar({super.key, this.onTap,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primaryBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                readOnly: true,
                onTap: onTap,
                decoration: InputDecoration(
                  hintText: AppStrings.hintServiceMasterSearch,
                  hintStyle: const TextStyle(fontSize: 14),
                  prefixIcon: const Icon(Icons.search, size: 20),
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
