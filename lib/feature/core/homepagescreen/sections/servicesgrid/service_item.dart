import 'package:flutter/material.dart';

import '../../../../../uikit/colors/app_colors.dart';
import '../../../../../uikit/widgets/card/networkimagewithplaceholder.dart';

class ServiceItem extends StatelessWidget {
  final String imageUrl;   // ✅ заменили category на прямую ссылку
  final String title;
  final String subtitle;

  const ServiceItem({super.key, required this.imageUrl,
    required this.title,
    required this.subtitle,});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Фото
          NetworkImageWithPlaceholder(
            url: imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorWidget: Container(
              color: Colors.grey[300],
              child: const Icon(Icons.broken_image, color: AppColors.primaryGrey),
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
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryWhite,
                  letterSpacing: 0.3,
                  // Очень мягкая тень для отделения от фона
                  shadows: [
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
