import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../colors/app_colors.dart';

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
    final effectiveWidth = (width != null && width!.isFinite) ? width : null;
    final effectiveHeight = (height != null && height!.isFinite) ? height : null;

    return CachedNetworkImage(
      imageUrl: url,
      width: effectiveWidth,
      height: effectiveHeight,
      fit: fit ?? BoxFit.cover,
      memCacheWidth: effectiveWidth?.toInt() ?? 400,
      memCacheHeight: effectiveHeight?.toInt() ?? 300,
      placeholder: (context, url) => const _LoadingPlaceholder(),
      errorWidget: (context, url, error) => const _DefaultErrorWidget(),
    );
  }
}

class _LoadingPlaceholder extends StatelessWidget {
  const _LoadingPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryBlue,
          strokeWidth: 2,
        ),
      ),
    );
  }
}

class _DefaultErrorWidget extends StatelessWidget {
  const _DefaultErrorWidget();

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
