import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/gallery/gallery_screen.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/gallery/sections/gallery_grid_preview.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Заголовок секции
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            AppStrings.portfolio,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Сетка из 5 картинок (превью)
        const GalleryGridPreview(),

        // Кнопка перехода к полной галерее
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GalleryScreen()),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: AppColors.primaryBlue,
                  width: 1.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                // Минимальный размер, чтобы кнопка выглядела аккуратно
                minimumSize: const Size(200, 40),
                padding: const EdgeInsets.symmetric(horizontal: 32),
              ),
              child: const Text(
                AppStrings.seeAllGallery,
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 15, // Чуть уменьшил для баланса с заголовком
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
