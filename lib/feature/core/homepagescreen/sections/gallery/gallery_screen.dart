import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/gallery/gallery_body.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../../uikit/colors/app_colors.dart';

class GalleryScreen extends StatelessWidget {
  final bool isMaster;
  final VoidCallback onRefresh;

  const GalleryScreen({
    super.key,
    required this.isMaster,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        title: const Text(
          AppStrings.portfolioGallery,
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryBlack,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: GalleryBody(
        isMaster: isMaster,
        onRefresh: onRefresh,
      ),
    );
  }
}
