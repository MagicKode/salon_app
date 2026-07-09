import 'package:salon_flutter/feature/catalog/data/models/category_dto.dart';

import '../../domain/repositories/catalog_repository.dart';
import '../datasources/catalog_remote_data_source.dart';
import '../models/catalog_image.dart';
import '../models/salon_model.dart';
import '../models/service_dto.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  final CatalogRemoteDataSource remoteDataSource;
  final Map<String, dynamic> _cache = {};

  CatalogRepositoryImpl({required this.remoteDataSource});

  @override
  Future<SalonEntity> getSalonDetails() async {
    const key = 'salon_details';
    if (_cache.containsKey(key)) {
      final cached = _cache[key];
      if (cached is SalonEntity) {
        return Future.value(cached);
      } else {
        _cache.remove(key);
      }
    }
    final data = await remoteDataSource.getSalonInfo();
    _cache[key] = data;
    return data;
  }

  @override
  Future<List<CatalogImage>> getImages(String relatedType, int relatedId, {int limit = 6}) async {
    final key = 'images_${relatedType}_${relatedId}_limit_$limit';
    if (_cache.containsKey(key)) {
      final cached = _cache[key];
      if (cached is List<CatalogImage>) {
        return Future.value(cached);
      } else {
        _cache.remove(key);
      }
    }
    final data = await remoteDataSource.getImages(relatedType, relatedId);
    if (data is List) {
      if (data.isNotEmpty) {
      }
    } else {
      throw Exception('remote data is not a List: ${data.runtimeType}');
    }
    _cache[key] = data;
    return data;
  }

  @override
  Future<List<ServiceDto>> getServices() async {
    const key = 'services_all';
    if (_cache.containsKey(key)) {
      final cached = _cache[key];
      if (cached is List<ServiceDto>) {
        return Future.value(cached);
      } else {
        _cache.remove(key);
      }
    }
    final data = await remoteDataSource.getServices();
    _cache[key] = data;
    return data;
  }

  @override
  Future<List<CategoryDto>> getCategories() async {
    const key = 'categories_all';
    if (_cache.containsKey(key)) {
      final cached = _cache[key];
      if (cached is List<CategoryDto>) {
        return Future.value(cached);
      } else {
        _cache.remove(key);
      }
    }
    final data = await remoteDataSource.getCategories();
    _cache[key] = data;
    return data;
  }

  @override
  Future<List<ServiceDto>> getServicesByCategory(int categoryId) async {
    final key = 'services_category_$categoryId';
    if (_cache.containsKey(key)) {
      final cached = _cache[key];
      if (cached is List<ServiceDto>) {
        return Future.value(cached);
      } else {
        _cache.remove(key);
      }
    }
    final data = await remoteDataSource.getServicesByCategory(categoryId);
    _cache[key] = data;
    return data;
  }

  @override
  Future<void> deleteImage(int imageId) async {
    await remoteDataSource.deleteImage(imageId);
    // очищаем локальный кеш изображений
    _cache.removeWhere((key, value) => key.startsWith('images_'));
  }

  @override
  Future<ServiceDto> updateService(ServiceDto service) async {
    final updated = await remoteDataSource.updateService(service);
    // Очищаем кеш услуг
    _cache.removeWhere((key, value) => key.startsWith('services_'));
    return updated;
  }

  @override
  void clearGalleryCache() {
    _cache.removeWhere((key, value) => key.startsWith('images_'));
    print('🗑️ Gallery cache cleared');
  }

  void clearCache() {
    _cache.clear();
  }
}
