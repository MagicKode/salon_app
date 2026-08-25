import 'package:flutter/material.dart';

import '../../../../config/theme/custom_colors.dart';
import '../images/networkimagewithplaceholder.dart';

class ServiceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? subtitle;
  final bool showDeleteButton;
  final VoidCallback? onDelete;

  const ServiceCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    this.showDeleteButton = false,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Фото
          NetworkImageWithPlaceholder(
            url: imageUrl,
            fit: BoxFit.cover,
            errorWidget: Container(
              color: colors.surfaceInput,
              child: Icon(Icons.broken_image, color: colors.textSecondary),
            ),
          ),

          // 2. ТЕМНЫЙ ОВЕРЛЕЙ (Вместо засвета)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.8),
                ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),

          // 3. ТЕКСТ (Теперь он будет гореть белым на темном фоне)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: 0.3,
                  shadows: const [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                maxLines: 2,
              ),
            ),
          ),

          // 4. Крестик удаления (если showDeleteButton == true)
          if (onDelete != null)
            Positioned(
              top: 6,
              right: 6,
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap: onDelete,
                  customBorder: const CircleBorder(),
                  splashColor: Colors.white.withOpacity(0.3),
                  highlightColor: Colors.white.withOpacity(0.1),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
