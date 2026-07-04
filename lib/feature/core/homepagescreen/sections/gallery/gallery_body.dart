import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../uikit/widgets/card/networkimagewithplaceholder.dart';
import '../../../../catalog/bloc/catalog_bloc.dart';
import '../../../../catalog/data/models/catalog_image.dart';
import '../../../../catalog/domain/repositories/catalog_repository.dart';
import 'domain/full_screen_image.dart';

class GalleryBody extends StatelessWidget {
  const GalleryBody({super.key});

  @override
  Widget build(BuildContext context) {
    // получаем репозиторий через Bloc (можно напрямую, если есть доступ)
    // Лучше добавить метод в Bloc, но для примера используем репозиторий напрямую
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
          padding: const EdgeInsets.all(16),
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
            final heroTag = 'image_${item.id}';

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    barrierColor: Colors.black.withOpacity(0.5),
                    transitionDuration: const Duration(milliseconds: 350),
                    pageBuilder: (_, __, ___) => FullScreenImage(
                      url: item.url,   // теперь полный URL
                      tag: 'image_${item.id}',
                    ),
                    transitionsBuilder: (_, animation, __, child) =>
                        FadeTransition(opacity: animation, child: child),
                  ),
                );
              },
              child: Hero(
                tag: 'image_${item.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: NetworkImageWithPlaceholder(
                    url: item.url,
                    fit: BoxFit.cover,
                    errorWidget: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
