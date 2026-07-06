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
        print('⚠️ Кеш салона содержит неправильный тип: ${cached.runtimeType}');
        _cache.remove(key);
      }
    }
    print('🌐 Загружаем салон с бэка');
    final data = await remoteDataSource.getSalonInfo();
    _cache[key] = data;
    return data;
  }

  @override
  Future<List<CatalogImage>> getImages(String relatedType, int relatedId) async {
    print('🔍 getImages: $relatedType, $relatedId');
    final key = 'images_${relatedType}_$relatedId';
    if (_cache.containsKey(key)) {
      final cached = _cache[key];
      print('🔍 cache hit, type = ${cached.runtimeType}');
      if (cached is List<CatalogImage>) {
        print('🔍 returning cached List<CatalogImage>');
        return Future.value(cached);
      } else {
        print('🔍 cache invalid, removing');
        _cache.remove(key);
      }
    }
    print('🔍 fetching from remote');
    final data = await remoteDataSource.getImages(relatedType, relatedId);
    print('🔍 remote data type = ${data.runtimeType}');
    if (data is List) {
      print('🔍 remote data length = ${data.length}');
      if (data.isNotEmpty) {
        print('🔍 first element type = ${data[0].runtimeType}');
      }
    } else {
      throw Exception('remote data is not a List: ${data.runtimeType}');
    }
    _cache[key] = data;
    print('🔍 returning data');
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
        print('⚠️ Кеш категорий содержит неправильный тип, удаляем');
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
        print('⚠️ Кеш услуг категории содержит неправильный тип, удаляем');
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

  void clearCache() {
    _cache.clear();
  }
}
