import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../uikit/colors/app_colors.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: AppStrings.hintServiceMasterSearch,
          hintStyle: const TextStyle(
            color: AppColors.primaryGrey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: const Icon(Icons.search, color: AppColors.primaryGrey),
          filled: true,
          fillColor: AppColors.boxDecorationColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }
}
