import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../uikit/widgets/card/networkimagewithplaceholder.dart';
import '../../../feature/catalog/data/models/catalog_image.dart';
import '../../../feature/catalog/domain/repositories/catalog_repository.dart';
import '../../../feature/core/homepagescreen/sections/gallery/domain/full_screen_image.dart';

class GalleryImageCard extends StatefulWidget {
  final CatalogImage image;
  final String heroTag;
  final bool enableDelete; // если true – доступно долгое нажатие для удаления
  final VoidCallback? onRefresh; // вызывается после удаления (только если enableDelete = true)

  const GalleryImageCard({
    super.key,
    required this.image,
    required this.heroTag,
    this.enableDelete = false,
    this.onRefresh,
  });

  @override
  State<GalleryImageCard> createState() => _GalleryImageCardState();
}

class _GalleryImageCardState extends State<GalleryImageCard> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            barrierColor: Colors.black.withOpacity(0.85),
            transitionDuration: const Duration(milliseconds: 350),
            pageBuilder: (_, __, ___) => FullScreenImage(
              url: widget.image.url,
              tag: widget.heroTag,
            ),
            transitionsBuilder: (_, animation, __, child) =>
                FadeTransition(opacity: animation, child: child),
          ),
        );
      },
      onLongPress: widget.enableDelete ? _showDeleteDialog : null,
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      child: Transform.scale(
        scale: _scale,
        child: Hero(
          tag: widget.heroTag,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: NetworkImageWithPlaceholder(
              url: widget.image.url,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorWidget: const Icon(Icons.broken_image, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить фото?'),
        content: const Text('Вы уверены, что хотите удалить это фото?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                final repo = context.read<CatalogRepository>();
                await repo.deleteImage(widget.image.id);
                if (widget.onRefresh != null) {
                  widget.onRefresh!();
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Фото удалено')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Ошибка удаления: $e'), backgroundColor: Colors.red),
                );
              }
            },
            child: const Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
