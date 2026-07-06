import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../uikit/colors/app_colors.dart';
import '../../../../../../uikit/widgets/card/networkimagewithplaceholder.dart';
import '../../../../../catalog/data/models/catalog_image.dart';
import '../../../../../catalog/domain/repositories/catalog_repository.dart';
import '../../../../../catalog/data/repositories/catalog_repository_impl.dart';

class GalleryGridPreview extends StatelessWidget {
  const GalleryGridPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.read<CatalogRepository>();
    if (repo is CatalogRepositoryImpl) {
      repo.clearCache();
    }

    return FutureBuilder<List<CatalogImage>>(
      future: repo.getImages('gallery', 0),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const SizedBox.shrink();
        }
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final data = snapshot.data!;
        if (data is! List) return const SizedBox.shrink();
        if (data.isNotEmpty && data[0] is! CatalogImage) {
          return const SizedBox.shrink();
        }

        final images = data.cast<CatalogImage>();
        if (images.length < 6) return const SizedBox.shrink();

        final displayImages = images.take(6).toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildTile(displayImages[0].url)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTile(displayImages[1].url)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _buildTile(displayImages[2].url)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTile(displayImages[3].url)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTile(displayImages[4].url)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTile(String url) => ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: NetworkImageWithPlaceholder(
      url: url,
      fit: BoxFit.cover,
      width: double.infinity,
      errorWidget: Container(
        color: Colors.grey[200],
        child: const Icon(Icons.broken_image, color: AppColors.primaryGrey),
      ),
    ),
  );
}
