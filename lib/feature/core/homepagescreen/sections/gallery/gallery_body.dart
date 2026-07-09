import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../uikit/widgets/card/images/gallery_image_card.dart';
import '../../../../catalog/data/models/catalog_image.dart';
import '../../../../catalog/domain/repositories/catalog_repository.dart';

class GalleryBody extends StatelessWidget {
  final bool isMaster;
  final VoidCallback onRefresh;

  const GalleryBody({
    super.key,
    required this.isMaster,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final repository = context.read<CatalogRepository>();

    return FutureBuilder<List<CatalogImage>>(
      future: repository.getImages('gallery', 0),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        }
        final images = snapshot.data ?? [];
        if (images.isEmpty) {
          return const Center(child: Text('Нет изображений'));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            final item = images[index];
            return GalleryImageCard(
              image: item,
              heroTag: 'image_${item.id}',
              enableDelete: isMaster,
              onRefresh: onRefresh,
            );
          },
        );
      },
    );
  }
}
