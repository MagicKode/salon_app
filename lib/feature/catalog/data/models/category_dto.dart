import 'catalog_image.dart';

class CategoryDto {
  final int id;
  final String name;
  final CatalogImage? image;
  final int sortOrder;

  const CategoryDto({
    required this.id,
    required this.name,
    this.image,
    required this.sortOrder,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json, {required String imagesBaseUrl}) {
    return CategoryDto(
      id: _toInt(json['id']),
      name: json['name'] as String? ?? '',
      image: json['image'] != null
          ? CatalogImage.fromJson(json['image'], imagesBaseUrl: imagesBaseUrl)
          : null,
      sortOrder: _toInt(json['sortOrder']),
    );
  }

  static int _toInt(dynamic value) => int.tryParse(value?.toString() ?? '') ?? 0;
}
