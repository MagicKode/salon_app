import 'package:flutter/material.dart';

import '../../../../../uikit/colors/app_colors.dart';
import '../../domain/home_models.dart';

class ServiceItem extends StatelessWidget {
  final ServiceCategory category;

  const ServiceItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Фото
          Image.asset(
            category.imagePath,
            fit: BoxFit.cover,
          ),

          // 2. ТЕМНЫЙ ОВЕРЛЕЙ (Вместо засвета)
          // Накладываем легкое затемнение на всю картинку + сильное вниз
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.1), // Легкая дымка сверху
                  Colors.black.withOpacity(0.8), // Плотный черный цвет внизу
                ],
                stops: const [0.0, 1.0], // Плавный переход от верха к низу
              ),
            ),
          ),

          // 3. ТЕКСТ (Теперь он будет гореть белым на темном фоне)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                category.title, // Можно убрать .toUpperCase() если хочешь строчными
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500, // Средняя толщина, не жирный
                  color: Colors.white,
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
