import 'catalog_service.dart';

class CatalogCategory {
  final String id;
  final String name;
  final String imagePath;
  final List<CatalogService> services;

  const CatalogCategory({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.services,
  });
}
