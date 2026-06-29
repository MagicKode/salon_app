import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class FullScreenImage extends StatelessWidget {
  final String assetPath;
  final String tag;

  const FullScreenImage({
    super.key,
    required this.assetPath,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 1. Фон (затемнение)
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              color: Colors.black.withValues(alpha: 0.8),
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // 2. Центрированная картинка на 90% экрана
          Center(
            child: InteractiveViewer(
              clipBehavior: Clip.none,
              // Позволяет картинке выходить за границы при зуме
              minScale: 1.0,
              maxScale: 4.0,
              child: Hero(
                tag: tag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  // Скругляем углы раскрытой картинки
                  child: Image.asset(
                    assetPath,
                    width: screenWidth * 0.9,
                    fit: BoxFit.contain, // Сохраняем пропорции
                  ),
                ),
              ),
            ),
          ),

          // 3. Кнопка закрытия (вынесена чуть дальше от края)
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            right: 20,
            child: Material(
              color: Colors.white.withValues(alpha: 0.2), // Подложка под крестик
              shape: const CircleBorder(),
              child: IconButton(
                icon: const Icon(Icons.close, color: AppColors.primaryWhite, size: 24),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
