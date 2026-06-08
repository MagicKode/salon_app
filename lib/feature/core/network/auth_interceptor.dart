import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;

  AuthInterceptor({required this.secureStorage});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1. ПРОВЕРКА ПУТИ: если это логин или регистрация — пропускаем без заголовков
    final path = options.path;
    if (path.contains('/auth/login') || path.contains('/auth/register')) {
      // Просто передаем запрос дальше без добавления токенов
      return handler.next(options);
    }

    if (options.extra['skip_auth_interceptor'] == true) {
      return handler.next(options);
    }

    // 2. Только для защищенных запросов извлекаем данные
    final token = await secureStorage.read(key: 'jwt_token');
    final phone = await secureStorage.read(key: 'user_phone');

    // 3. Добавляем токен, только если он есть
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // 4. Добавляем X-User-Name
    options.headers['X-User-Name'] =
        (phone != null && phone.isNotEmpty) ? phone : 'Anonym';

    // 5. Указываем тип контента
    options.headers['Content-Type'] = 'application/json';

    print("[AuthInterceptor] Заголовки успешно применены: ${options.headers}");

    return handler.next(options);
  }
}
