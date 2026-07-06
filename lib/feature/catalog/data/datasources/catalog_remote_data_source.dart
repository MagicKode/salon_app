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

  dynamic _extractData(Response response) {
    if (response.statusCode != 200 || response.data == null) {
      throw Exception('Ошибка сервера: ${response.statusCode}');
    }
    final data = response.data['data'];
    print('🌐 Extracted data: $data');
    if (data == null) {
      throw Exception('Данные отсутствуют');
    }
    return data;
  }

  @override
  Future<SalonModel> getSalonInfo() async {
    try {
      final response = await dio.get(baseUrl);
      final data = _extractData(response);
      return SalonModel.fromJson(data);
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? AppStrings.errorNetworkInGettingCatalog;
      throw Exception(errorMessage);
    }
  }

  @override
  Future<List<CatalogImage>> getImages(String relatedType, int relatedId) async {
    final response = await dio.get(
      '$imagesBaseUrl/by-related',
      queryParameters: {'relatedType': relatedType, 'relatedId': relatedId},
    );
    final data = _extractData(response);
    return (data as List)
        .map((json) => CatalogImage.fromJson(json, imagesBaseUrl: imagesBaseUrl))
        .toList();
  }

  @override
  Future<List<ServiceDto>> getServices() async{
    try {
      final response = await dio.get(servicesBaseUrl);
      final data = _extractData(response);
      if (data is! List) {
        throw Exception('Неверный формат данных');
      }
      return data.map((json) => ServiceDto.fromJson(json, imagesBaseUrl: imagesBaseUrl)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Ошибка загрузки услуг');
    }
  }

  @override
  Future<List<CategoryDto>> getCategories() async {
    try {
      final response = await dio.get(categoriesBaseUrl);
      final data = _extractData(response);
      if (data is! List) {
        throw Exception('Неверный формат данных');
      }
      return data.map((json) => CategoryDto.fromJson(json, imagesBaseUrl: imagesBaseUrl)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Ошибка загрузки категорий');
    }
  }

  @override
  Future<List<ServiceDto>> getServicesByCategory(int categoryId) async {
    try {
      final response = await dio.get('$servicesBaseUrl/by-category/$categoryId');
      final data = _extractData(response);
      if (data is! List) {
        throw Exception('Неверный формат данных');
      }
      return data.map((json) => ServiceDto.fromJson(json, imagesBaseUrl: imagesBaseUrl)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Ошибка загрузки услуг категории');
    }
  }
}
