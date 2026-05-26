import 'package:dio/dio.dart';
import '../models/salon_model.dart';

abstract class CatalogRemoteDataSource {
  Future<SalonModel> getSalonInfo();
}

class CatalogRemoteDataSourceImpl implements CatalogRemoteDataSource {
  final Dio dio;

  // Твой базовый URL к шлюзу (локальный IP для эмулятора Android)
  static const String _baseUrl = 'http://10.0.2.2:8080/api/v1/catalog/salon';

  CatalogRemoteDataSourceImpl({required this.dio});

  @override
  Future<SalonModel> getSalonInfo() async {
    try {
      final response = await dio.get(_baseUrl);

      if (response.statusCode == 200 && response.data != null) {
        // Парсим в соответствии со структурой ответа бэкенда: response.data['data']
        final Map<String, dynamic> dataBody = response.data['data'] as Map<String, dynamic>;
        return SalonModel.fromJson(dataBody);
      } else {
        throw Exception('Не удалось загрузить данные каталога');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? 'Ошибка сети при получении каталога';
      throw Exception(errorMessage);
    }
  }
}
