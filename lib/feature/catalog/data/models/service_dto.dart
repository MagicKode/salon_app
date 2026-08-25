import 'catalog_image.dart';

class ServiceDto {
  final int id;
  final String name;
  final String description;
  final double price;
  final int durationMinutes;
  final int? categoryId;
  final int sortOrder;
  final CatalogImage? image;
  final bool isDeleted;

  const ServiceDto({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationMinutes,
    this.categoryId,
    required this.sortOrder,
    this.image,
    this.isDeleted = false,
  });

  factory ServiceDto.fromJson(Map<String, dynamic> json, {required String imagesBaseUrl}) {
    return ServiceDto(
      id: _toInt(json['id']),
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: _toDouble(json['price']),
      durationMinutes: _toInt(json['durationMinutes']),
      categoryId: json['categoryId'] != null ? _toInt(json['categoryId']) : null,
      sortOrder: _toInt(json['sortOrder']),
      image: json['image'] != null
          ? CatalogImage.fromJson(json['image'], imagesBaseUrl: imagesBaseUrl)
          : null,
      isDeleted: json['isActive'] == null ? false : !json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'durationMinutes': durationMinutes,
      'categoryId': categoryId,
      'sortOrder': sortOrder,
      'image': image?.toJson(),
    };
  }

  static int _toInt(dynamic value) => int.tryParse(value?.toString() ?? '') ?? 0;
  static double _toDouble(dynamic value) => double.tryParse(value?.toString() ?? '') ?? 0.0;
}
