import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../../../../../../uikit/widgets/card/networkimagewithplaceholder.dart';

class FullScreenImage extends StatelessWidget {
  final String url;
  final String tag;

  const FullScreenImage({super.key, required this.url, required this.tag});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 1. Фон (затемнение)
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              color: Colors.black.withOpacity(0.85),
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // 2. Центрированная картинка на 90% экрана
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: InteractiveViewer(
                clipBehavior: Clip.none,
                minScale: 1.0,
                maxScale: 4.0,
                child: Hero(
                  tag: tag,
                  child: NetworkImageWithPlaceholder(
                    url: url,
                    fit: BoxFit.contain,
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.8,
                    errorWidget: const Icon(Icons.broken_image, color: Colors.white, size: 48),
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
              color: Colors.white.withOpacity(0.2),
              shape: const CircleBorder(),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 24),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
