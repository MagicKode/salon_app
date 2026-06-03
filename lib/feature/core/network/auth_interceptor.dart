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
    // 1. Извлекаем сохраненные данные
    final token = await secureStorage.read(key: 'jwt_token');
    final phone = await secureStorage.read(key: 'user_phone');

    // 2. Если токен есть, добавляем его в заголовки
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // 3. Если телефон есть в памяти, прокидываем его в X-User-Name для booking-service.
    // Если пустой (например, тестовый запуск) — ставим 'Anonym' как фолбэк, чтобы Спринг не ругался 400.
    options.headers['X-User-Name'] = (phone != null && phone.isNotEmpty) ? phone : 'Anonym';

    // Обязательно указываем тип контента для POST запросов
    options.headers['Content-Type'] = 'application/json';

    print("[AuthInterceptor] Заголовки успешно применены: ${options.headers}");

    return handler.next(options);
  }
}
