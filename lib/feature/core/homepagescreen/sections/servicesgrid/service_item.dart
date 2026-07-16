import 'package:flutter/material.dart';

import '../../../../../config/theme/custom_colors.dart';
import '../../../../../uikit/widgets/card/images/networkimagewithplaceholder.dart';

class ServiceItem extends StatelessWidget {
  final String imageUrl; // ✅ заменили category на прямую ссылку
  final String title;
  final String subtitle;

  const ServiceItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
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
        ],
      ),
    );
  }
}
