import 'package:dio/dio.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../models/salon_model.dart';

abstract class CatalogRemoteDataSource {
  Future<SalonModel> getSalonInfo();
}

class CatalogRemoteDataSourceImpl implements CatalogRemoteDataSource {
  final Dio dio;
  final String baseUrl;

  CatalogRemoteDataSourceImpl({
    required this.dio,
    required this.baseUrl, // Передаем значение из main.dart
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
}
