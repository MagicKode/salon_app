class CatalogImage {
  final int id;
  final String url;

  const CatalogImage({required this.id, required this.url});

  // Передаём imagesBaseUrl при создании
  factory CatalogImage.fromJson(Map<String, dynamic> json, {required String imagesBaseUrl}) {
    final int id = json['id'];
    return CatalogImage(
      id: id,
      url: '$imagesBaseUrl/$id',   // imagesBaseUrl = http://10.0.2.2:8081/api/v1/catalog/images
    );
  }
}
