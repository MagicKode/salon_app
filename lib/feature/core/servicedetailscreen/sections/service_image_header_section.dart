import 'package:flutter/material.dart';

import '../../../../uikit/colors/app_colors.dart';

class ServiceImageHeaderSection extends StatelessWidget {
  final String title;
  final String imageUrl;

  const ServiceImageHeaderSection({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: const Color(0xFF093882),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(title, style: const TextStyle(color: AppColors.primaryWhite, fontSize: 16)),
        background: Image.network(imageUrl, fit: BoxFit.cover),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.3),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.primaryWhite),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}