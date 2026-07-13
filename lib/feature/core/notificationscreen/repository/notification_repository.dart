import 'package:dio/dio.dart';

import '../domain/notification_model.dart';

class NotificationRepository {
  final Dio _dio;
  final String baseUrl;

  NotificationRepository({required Dio dio, required this.baseUrl}) : _dio = dio;

  Future<List<NotificationModel>> getNotifications(String clientPhone) async {
    final response = await _dio.get(
      baseUrl,
      options: Options(headers: {'X-User-Name': clientPhone}),
    );
    return (response.data as List)
        .map((j) => NotificationModel.fromJson(j))
        .toList();
  }

  Future<int> getUnreadCount(String clientPhone) async {
    final response = await _dio.get(
      '$baseUrl/unread-count',
      options: Options(headers: {'X-User-Name': clientPhone}),
    );
    return response.data as int;
  }

  Future<void> markAsRead(int id) async {
    await _dio.patch('$baseUrl/$id/read');
  }

  Future<void> saveFcmToken(String clientPhone, String fcmToken) async {
    await _dio.post(
      '$baseUrl/token',
      data: {'token': fcmToken},
      options: Options(headers: {'X-User-Name': clientPhone}),
    );
  }

  Future<int> broadcastToAll(String title, String body, String masterPhone) async {
    final response = await _dio.post(   // ✅ POST
      '$baseUrl/broadcast',
      data: {
        'title': title,
        'body': body,
        'type': 'GENERAL'
      },
      options: Options(
        headers: {'X-User-Name': masterPhone},
      ),
    );
    return response.data['data'] as int;
  }

  Future<void> deleteNotification(int id) async {
    await _dio.delete('$baseUrl/$id');
  }
}
