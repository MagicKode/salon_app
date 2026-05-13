import 'package:flutter/material.dart';

import 'domain/full_screen_image.dart';
import 'domain/gallery_item.dart';

class GalleryBody extends StatelessWidget {
  const GalleryBody({super.key});

  @override
  Widget build(BuildContext context) {
    final images = GalleryData.mockItems;

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
        // Уникальный тег для анимации Hero
        final String heroTag = 'image_${item.id}';

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false, // Оставляем галерею видимой под размытием
                barrierColor: Colors.black.withOpacity(0.5),
                transitionDuration: const Duration(milliseconds: 350), // Чуть медленнее для солидности
                pageBuilder: (context, _, __) => FullScreenImage(
                  assetPath: item.imageUrl,
                  tag: heroTag,
                ),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          },
          child: Hero(
            tag: heroTag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                item.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
