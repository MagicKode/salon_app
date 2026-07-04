import 'package:dio/dio.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../models/catalog_image.dart';
import '../models/category_dto.dart';
import '../models/salon_model.dart';
import '../models/service_dto.dart';

abstract class CatalogRemoteDataSource {
  Future<SalonModel> getSalonInfo();
  Future<List<CatalogImage>> getImages(String relatedType, int relatedId);
  Future<List<ServiceDto>> getServices();
  Future<List<CategoryDto>> getCategories();
  Future<List<ServiceDto>> getServicesByCategory(int categoryId);
}

class CatalogRemoteDataSourceImpl implements CatalogRemoteDataSource {
  final Dio dio;
  final String baseUrl;
  final String imagesBaseUrl;
  final String servicesBaseUrl;
  final String categoriesBaseUrl;


  CatalogRemoteDataSourceImpl({
    required this.dio,
    required this.baseUrl, // Передаем значение из main.dart
    required this.imagesBaseUrl,
    required this.servicesBaseUrl,
    required this.categoriesBaseUrl
  });

  @override
  Future<SalonModel> getSalonInfo() async {
    try {
      final response = await dio.get(baseUrl);

      if (response.statusCode == 200 && response.data != null) {
        // Парсим в соответствии со структурой ответа бэкенда: response.data['data']
        final Map<String, dynamic> dataBody =
            response.data['data'] as Map<String, dynamic>;
        return SalonModel.fromJson(dataBody);
      } else {
        throw Exception(AppStrings.errorInLoadingCatalogData);
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? AppStrings.errorNetworkInGettingCatalog;
      throw Exception(errorMessage);
    }
  }

  @override
  Future<List<CatalogImage>> getImages(String relatedType, int relatedId) async {
    final response = await dio.get(
      '$imagesBaseUrl/by-related',
      queryParameters: {
        'relatedType': relatedType,
        'relatedId': relatedId,
      },
    );
    return (response.data as List)
        .map((json) => CatalogImage.fromJson(json, imagesBaseUrl: imagesBaseUrl))
        .toList();
  }

  @override
  Future<List<ServiceDto>> getServices() async{
    final response = await dio.get(servicesBaseUrl);
    return (response.data as List)
        .map((j) => ServiceDto.fromJson(j, imagesBaseUrl: imagesBaseUrl))
        .toList();
  }

  @override
  Future<List<CategoryDto>> getCategories() async {
    final response = await dio.get(categoriesBaseUrl);
    return (response.data as List)
        .map((j) => CategoryDto.fromJson(j, imagesBaseUrl: imagesBaseUrl))
        .toList();
  }

  @override
  Future<List<ServiceDto>> getServicesByCategory(int categoryId) async {
    final response = await dio.get('$servicesBaseUrl/by-category/$categoryId');
    return (response.data as List)
        .map((j) => ServiceDto.fromJson(j, imagesBaseUrl: imagesBaseUrl))
        .toList();
  }
}
