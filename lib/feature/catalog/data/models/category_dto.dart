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
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] != null
          ? CatalogImage.fromJson(json['image'], imagesBaseUrl: imagesBaseUrl)
          : null,
      sortOrder: json['sortOrder'] as int? ?? 0,
    );
  }
}
