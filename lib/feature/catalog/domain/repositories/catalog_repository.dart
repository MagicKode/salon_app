import 'dart:io';

import '../../data/models/catalog_image.dart';
import '../../data/models/category_dto.dart';
import '../../data/models/salon_model.dart';
import '../../data/models/service_dto.dart';

abstract class CatalogRepository {
  Future<SalonEntity> getSalonDetails();
  Future<List<CatalogImage>> getImages(String relatedType, int relatedId, {int limit = 6});
  Future<List<ServiceDto>> getServices();
  Future<List<CategoryDto>> getCategories();
  Future<List<ServiceDto>> getServicesByCategory(int categoryId);
  Future<void> deleteImage(int imageId);
  Future<ServiceDto> updateService(ServiceDto service);
  void clearGalleryCache();
  Future<String> uploadServiceImage(File image);
  Future<ServiceDto> createService({
    required String name,
    required double price,
    required int durationMinutes,
    String? description,
    String? imageId,
    int? categoryId,
    int? sortOrder,
  });
}
