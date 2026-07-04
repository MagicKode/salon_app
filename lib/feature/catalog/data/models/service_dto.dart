import 'catalog_image.dart';

class ServiceDto {
  final int id;
  final String name;
  final String description;
  final String category;
  final double price;
  final int durationMinutes;
  final int sortOrder;
  final CatalogImage? image;

  const ServiceDto({
    required this.id, required this.name, required this.description,
    required this.price, required this.durationMinutes,
    required this.category, required this.sortOrder, this.image,
  });

  factory ServiceDto.fromJson(Map<String, dynamic> json, {required String imagesBaseUrl}) {
    return ServiceDto(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      durationMinutes: json['durationMinutes'] ?? 60,
      category: json['category'] ?? '',
      sortOrder: json['sortOrder'] ?? 0,
      image: json['image'] != null
          ? CatalogImage.fromJson(json['image'], imagesBaseUrl: imagesBaseUrl)
          : null,
    );
  }
}
