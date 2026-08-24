import 'dart:io';

import 'package:dio/dio.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../models/catalog_image.dart';
import '../models/category_dto.dart';
import '../models/salon_model.dart';
import '../models/service_dto.dart';

abstract class CatalogRemoteDataSource {
  Future<SalonModel> getSalonInfo();

  Future<List<CatalogImage>> getImages(
    String relatedType,
    int relatedId, {
    int limit = 6,
  });

  Future<List<ServiceDto>> getServices();

  Future<List<CategoryDto>> getCategories();

  Future<List<ServiceDto>> getServicesByCategory(int categoryId);

  Future<void> deleteImage(int imageId);

  Future<ServiceDto> updateService(ServiceDto service);

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

class CatalogRemoteDataSourceImpl implements CatalogRemoteDataSource {
  final Dio dio;
  final String baseUrl;
  final String imagesBaseUrl;
  final String servicesBaseUrl;
  final String categoriesBaseUrl;
  final String imagesUploadUrl;

  CatalogRemoteDataSourceImpl({
    required this.dio,
    required this.baseUrl,
    required this.imagesBaseUrl,
    required this.servicesBaseUrl,
    required this.categoriesBaseUrl,
    required this.imagesUploadUrl,
  });

  dynamic _extractData(Response response) {
    if (response.statusCode != 200 || response.data == null) {
      throw Exception('Ошибка сервера: ${response.statusCode}');
    }
    print('📄 response.data type = ${response.data.runtimeType}');
    if (response.data is List) {
      print('📄 response.data is List, returning directly');
      return response.data;
    }

    if (response.data is Map) {
      final data = response.data['data'];
      print('📄 extracted data from map = $data');
      if (data == null) {
        throw Exception('Данные отсутствуют');
      }
      return data;
    }
    throw Exception('Неизвестный формат ответа: ${response.data.runtimeType}');
  }

  @override
  Future<SalonModel> getSalonInfo() async {
    try {
      final response = await dio.get(baseUrl);
      final data = _extractData(response);
      return SalonModel.fromJson(data);
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ??
          AppStrings.errorNetworkInGettingCatalog;
      throw Exception(errorMessage);
    }
  }

  @override
  Future<List<CatalogImage>> getImages(
    String relatedType,
    int relatedId, {
    int limit = 999,
  }) async {
    final response = await dio.get(
      '$imagesBaseUrl/by-related',
      queryParameters: {
        'relatedType': relatedType,
        'relatedId': relatedId,
        'limit': limit,
      },
    );
    final data = _extractData(response);
    if (data is List) {
      if (data.isNotEmpty) {}
    } else {
      throw Exception('Ожидался список, получено: ${data.runtimeType}');
    }
    final result =
        (data as List)
            .map(
              (json) =>
                  CatalogImage.fromJson(json, imagesBaseUrl: imagesBaseUrl),
            )
            .toList();
    return result;
  }

  @override
  Future<List<ServiceDto>> getServices() async {
    try {
      final response = await dio.get(servicesBaseUrl);
      final data = _extractData(response);
      if (data is! List) {
        throw Exception('Неверный формат данных');
      }
      return data
          .map(
            (json) => ServiceDto.fromJson(json, imagesBaseUrl: imagesBaseUrl),
          )
          .toList();
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
      return data
          .map(
            (json) => CategoryDto.fromJson(json, imagesBaseUrl: imagesBaseUrl),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Ошибка загрузки категорий',
      );
    }
  }

  @override
  Future<List<ServiceDto>> getServicesByCategory(int categoryId) async {
    try {
      final response = await dio.get(
        '$servicesBaseUrl/by-category/$categoryId',
      );
      final data = _extractData(response);
      if (data is! List) {
        throw Exception('Неверный формат данных');
      }
      return data
          .map(
            (json) => ServiceDto.fromJson(json, imagesBaseUrl: imagesBaseUrl),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Ошибка загрузки услуг категории',
      );
    }
  }

  @override
  Future<void> deleteImage(int imageId) async {
    await dio.delete('$imagesBaseUrl/$imageId');
  }

  @override
  Future<ServiceDto> updateService(ServiceDto service) async {
    final response = await dio.patch(
      '$servicesBaseUrl/${service.id}',
      data: {'description': service.description},
    );
    final data = response.data['data'];
    return ServiceDto.fromJson(data, imagesBaseUrl: imagesBaseUrl);
  }

  @override
  Future<ServiceDto> createService({
    required String name,
    required double price,
    required int durationMinutes,
    String? description,
    String? imageId,
    int? categoryId,
    int? sortOrder,
  }) async {
    final body = {
      'name': name,
      'price': price,
      'durationMinutes': durationMinutes,
      'description': description ?? '',
      'imageId': imageId, // если бэкенд ожидает это поле
      'categoryId': categoryId,
      'sortOrder': sortOrder ?? 0,
    };
    final response = await dio.post(
      servicesBaseUrl,
      data: body,
    );
    final data = response.data['data'] ?? response.data;
    return ServiceDto.fromJson(data, imagesBaseUrl: imagesBaseUrl);
  }

  @override
  Future<String> uploadServiceImage(File image) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(image.path),
    });
    final response = await dio.post(
      imagesUploadUrl,
      queryParameters: {
        'relatedType': 'service'
      },
      data: formData,
    );
    // Предположим, ответ: { "id": 123 }
    return response.data['id'].toString();
  }
}
