import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/gallery/gallery_body.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../../config/theme/custom_colors.dart';

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
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      backgroundColor: colors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: colors.backgroundPrimary,
        title: Text(
          AppStrings.portfolioGallery,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: colors.textPrimary,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: GalleryBody(isMaster: isMaster, onRefresh: onRefresh),
    );
  }
}
