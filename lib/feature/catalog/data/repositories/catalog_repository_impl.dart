import 'package:salon_flutter/feature/catalog/data/models/category_dto.dart';

import '../../domain/repositories/catalog_repository.dart';
import '../datasources/catalog_remote_data_source.dart';
import '../models/catalog_image.dart';
import '../models/salon_model.dart';
import '../models/service_dto.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  final CatalogRemoteDataSource remoteDataSource;

  CatalogRepositoryImpl({required this.remoteDataSource});

  @override
  Future<SalonEntity> getSalonDetails() async {
    return await remoteDataSource.getSalonInfo();
  }

  @override
  Future<List<CatalogImage>> getImages(String relatedType, int relatedId) =>
      remoteDataSource.getImages(relatedType, relatedId);

  @override
  Future<List<ServiceDto>> getServices() => remoteDataSource.getServices();

  @override
  Future<List<CategoryDto>> getCategories() => remoteDataSource.getCategories();

  @override
  Future<List<ServiceDto>> getServicesByCategory(int categoryId) =>
      remoteDataSource.getServicesByCategory(categoryId);
}
