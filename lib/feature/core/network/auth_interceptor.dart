import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;

  AuthInterceptor({required this.secureStorage});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // 1. Достаем токен из безопасного хранилища телефона
    final token = await secureStorage.read(key: 'jwt_token');

    // 2. Если токен есть — автоматически добавляем его в заголовки запроса
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // 3. Пропускаем запрос дальше
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Здесь в будущем можно будет ловить 401 ошибку (истек токен) и разлогинивать юзера
    super.onError(err, handler);
  }
}
