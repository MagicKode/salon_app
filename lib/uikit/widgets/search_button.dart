import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class SearchButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SearchButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: AppColors.boxDecorationColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(
          Icons.search,
          color: AppColors.primaryBlue,
          size: 24,
        ),
        onPressed: onPressed,
      ),
    );
  }
}