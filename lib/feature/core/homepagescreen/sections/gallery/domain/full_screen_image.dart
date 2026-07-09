import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import '../../../../../../uikit/widgets/card/images/networkimagewithplaceholder.dart';

class FullScreenImage extends StatelessWidget {
  final String url;
  final String tag;

  const FullScreenImage({super.key, required this.url, required this.tag});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // 1. Затемнение фона
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            color: Colors.black38,
            width: double.infinity,
            height: double.infinity,
          ),
        ),

        // 2. Картинка с Hero и скруглениями
        Center(
          child: Hero(
            tag: tag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: NetworkImageWithPlaceholder(
                url: url,
                fit: BoxFit.cover, // ✅ меняем на cover
                width: screenWidth * 0.90,
                height: screenHeight * 0.65,
                errorWidget: const Icon(Icons.broken_image, color: Colors.white, size: 48),
              ),
            ),
          ),
        ),

        // 3. Кнопка закрытия
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
    );
  }
}
