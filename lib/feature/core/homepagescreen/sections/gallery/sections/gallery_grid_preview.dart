import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../uikit/colors/app_colors.dart';
import '../../../../../../uikit/widgets/card/images/networkimagewithplaceholder.dart';
import '../../../../../catalog/data/models/catalog_image.dart';
import '../../../../../catalog/domain/repositories/catalog_repository.dart';

class GalleryGridPreview extends StatelessWidget {
  const GalleryGridPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.read<CatalogRepository>();
    const spacing = 6.0;
    const horizontalPadding = 16.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth - horizontalPadding * 2;

    // Размеры плиток
    final bigWidth = (availableWidth - spacing) / 2;
    final smallWidth = (availableWidth - spacing * 2) / 3;
    // Задаём единое соотношение сторон для всех плиток (например, 3:4)
    final aspectRatio = 1.15;
    final bigHeight = bigWidth * aspectRatio;
    final smallHeight = smallWidth * aspectRatio;

    return FutureBuilder<List<CatalogImage>>(
      future: repo.getImages('gallery', 0, limit: 999),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final data = snapshot.data!;
        if (data is! List || data.isEmpty || data[0] is! CatalogImage) {
          return const SizedBox.shrink();
        }

        final images = data.cast<CatalogImage>();
        final displayImages = images.take(5).toList();
        if (displayImages.length < 5) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              // Верхний ряд: 2 большие картинки
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: _buildTile(
                        displayImages[0].url,
                        bigWidth,
                        bigHeight,
                      ),
                    ),
                    const SizedBox(width: spacing),
                    Expanded(
                      child: _buildTile(
                        displayImages[1].url,
                        bigWidth,
                        bigHeight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: spacing),
              // Нижний ряд: 3 маленькие картинки
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: _buildTile(
                        displayImages[2].url,
                        smallWidth,
                        smallHeight,
                      ),
                    ),
                    const SizedBox(width: spacing),
                    Expanded(
                      child: _buildTile(
                        displayImages[3].url,
                        smallWidth,
                        smallHeight,
                      ),
                    ),
                    const SizedBox(width: spacing),
                    Expanded(
                      child: _buildTile(
                        displayImages[4].url,
                        smallWidth,
                        smallHeight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTile(String url, double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: NetworkImageWithPlaceholder(
          url: url,
          fit: BoxFit.cover,
          width: width,
          // передаём явно
          height: height,
          // передаём явно
          errorWidget: Container(
            color: Colors.grey[200],
            child: const Icon(Icons.broken_image, color: AppColors.primaryGrey),
          ),
        ),
      ),
    );
  }
}
