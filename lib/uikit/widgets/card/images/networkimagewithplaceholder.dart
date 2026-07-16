import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/theme/custom_colors.dart';

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
    // ✅ Получаем динамические цвета внутри билдера
    final colors = Theme.of(context).extension<CustomColors>()!;

    final effectiveWidth = (width != null && width!.isFinite) ? width : null;
    final effectiveHeight =
        (height != null && height!.isFinite) ? height : null;

    return CachedNetworkImage(
      imageUrl: url,
      width: effectiveWidth,
      height: effectiveHeight,
      fit: fit ?? BoxFit.cover,
      memCacheWidth: effectiveWidth?.toInt() ?? 400,
      memCacheHeight: effectiveHeight?.toInt() ?? 300,
      placeholder: (context, url) => _LoadingPlaceholder(colors: colors),
      errorWidget: (context, url, error) => _DefaultErrorWidget(colors: colors),
    );
  }
}

class _LoadingPlaceholder extends StatelessWidget {
  final CustomColors colors;

  const _LoadingPlaceholder({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.surfaceInput, // ✅ динамический фон
      child: Center(
        child: CircularProgressIndicator(
          color: colors.primaryBlue, // ✅ динамический синий
          strokeWidth: 2,
        ),
      ),
    );
  }
}

class _DefaultErrorWidget extends StatelessWidget {
  final CustomColors colors;

  const _DefaultErrorWidget({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.surfaceInput, // ✅ динамический фон
      child: Center(
        child: Icon(
          Icons.broken_image,
          color: colors.textSecondary, // ✅ динамический серый
          size: 48,
        ),
      ),
    );
  }
}
