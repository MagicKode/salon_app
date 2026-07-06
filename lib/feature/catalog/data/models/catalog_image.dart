class CatalogImage {
  final int id;
  final String url;

  const CatalogImage({required this.id, required this.url});

  factory CatalogImage.fromJson(Map<String, dynamic> json, {required String imagesBaseUrl}) {
    final int id = _toInt(json['id']);
    final String fullUrl = '$imagesBaseUrl/$id';
    print('🖼️ [CatalogImage] id=$id, fullUrl=$fullUrl'); // 👈 лог
    return CatalogImage(
      id: id,
      url: fullUrl,
    );
  }

  static int _toInt(dynamic value) => int.tryParse(value?.toString() ?? '') ?? 0;

  @override
  String toString() => 'CatalogImage(id: $id, url: $url)';
}
