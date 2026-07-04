import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../uikit/colors/app_colors.dart';
import '../../../../../../uikit/widgets/card/networkimagewithplaceholder.dart';
import '../../../../../catalog/data/models/catalog_image.dart';
import '../../../../../catalog/domain/repositories/catalog_repository.dart';
import '../domain/gallery_item.dart';

class GalleryGridPreview extends StatelessWidget {
  const GalleryGridPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.read<CatalogRepository>();

    return FutureBuilder<List<CatalogImage>>(
      future: repo.getImages('gallery', 0),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data!.length < 5) {
          return const SizedBox.shrink();
        }

        final images = snapshot.data!.take(6).toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // Первый ряд
              Row(
                children: [
                  Expanded(child: _buildTile(images[0].url)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTile(images[1].url)),
                ],
              ),
              const SizedBox(height: 8),
              // Второй ряд
              Row(
                children: [
                  Expanded(child: _buildTile(images[3].url)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTile(images[4].url)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTile(images[5].url)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Вспомогательный метод для отрисовки плитки
  Widget _buildTile(String url) => ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: NetworkImageWithPlaceholder(
        url: url,
        fit: BoxFit.cover,
        width: double.infinity,
        errorWidget: Container(
          color: Colors.grey[200],
          child: const Icon(Icons.broken_image,
              color: AppColors.primaryGrey),
        ),
      ),
    ),
  );
}
