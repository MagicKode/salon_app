import 'package:salon_flutter/feature/catalog/data/models/catalog_image.dart';

class GalleryState {
  final List<CatalogImage> images;
  final bool isLoading;
  final String? error;

  const GalleryState({
    required this.images,
    this.isLoading = false,
    this.error,
  });

  factory GalleryState.initial() {
    return const GalleryState(images: []);
  }

  GalleryState copyWith({
    List<CatalogImage>? images,
    bool? isLoading,
    String? error,
  }) {
    return GalleryState(
      images: images ?? this.images,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}