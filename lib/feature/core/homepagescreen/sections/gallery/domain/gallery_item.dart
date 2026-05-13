class GalleryItem {
  final String id;
  final String imageUrl;

  const GalleryItem({required this.id, required this.imageUrl});
}

class GalleryData {
  static const int _totalImages = 25;

  static List<GalleryItem> get mockItems => List.generate(
    _totalImages,
        (index) {
      final int number = index + 1;
      return GalleryItem(
        id: number.toString(),
        imageUrl: 'assets/images/portfolio/image_$number.jpeg',
      );
    },
  );
}
