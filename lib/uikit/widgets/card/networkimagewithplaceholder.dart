import 'package:flutter/material.dart';

import '../../colors/app_colors.dart';

class NetworkImageWithPlaceholder extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorWidget;

  const NetworkImageWithPlaceholder({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child; // загружено
        }
        // Анимированный плейсхолдер
        return _LoadingPlaceholder(
          progress: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
              : null,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ?? _DefaultErrorWidget();
      },
    );
  }
}

// Анимированный плейсхолдер с пульсацией
class _LoadingPlaceholder extends StatefulWidget {
  final double? progress; // от 0 до 1
  const _LoadingPlaceholder({this.progress});

  @override
  State<_LoadingPlaceholder> createState() => _LoadingPlaceholderState();
}

class _LoadingPlaceholderState extends State<_LoadingPlaceholder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.primary.withOpacity(0.2);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          color: Color.lerp(color, color.withOpacity(0.05), _controller.value),
          child: Center(
            child: widget.progress != null
                ? CircularProgressIndicator(
              value: widget.progress,
              strokeWidth: 2,
              color: theme.colorScheme.primary,
            )
                : const CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
    );
  }
}

// Заглушка при ошибке загрузки
class _DefaultErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.broken_image, color: AppColors.primaryGrey, size: 48),
      ),
    );
  }
}
