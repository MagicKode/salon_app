import 'package:flutter/material.dart';
import '../../../../../../uikit/colors/app_colors.dart';
import '../domain/gallery_item.dart';

class GalleryGridPreview extends StatelessWidget {
  const GalleryGridPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final images = GalleryData.mockItems;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 240,
        child: Row(
          children: [

            // 1. Большое фото (слева)
            Expanded(
              flex: 2,
              child: _buildTile(images[0].imageUrl),
            ),
            const SizedBox(width: 8),

            // 2. Сетка 2x2 (справа)
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: _buildTile(images[1].imageUrl)),
                        const SizedBox(width: 8),
                        Expanded(child: _buildTile(images[2].imageUrl)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: _buildTile(images[3].imageUrl)),
                        const SizedBox(width: 8),
                        Expanded(child: _buildTile(images[4].imageUrl)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Вспомогательный метод для отрисовки плитки
  Widget _buildTile(String assetPath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        assetPath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        // Заглушка на случай, если вы ошиблись в названии файла в ассетах
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey[200],
          child: const Icon(Icons.broken_image, color: AppColors.primaryGrey),
        ),
      ),
    );
  }
}