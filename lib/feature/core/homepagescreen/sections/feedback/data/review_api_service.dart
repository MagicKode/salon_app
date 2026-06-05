import 'package:dio/dio.dart';

import '../reviewmodel/review_model.dart';
import '../reviewmodel/review_stats_model.dart';

class ReviewApiService {
  final Dio _dio;
  final String baseUrl;

  ReviewApiService({required Dio dio, required this.baseUrl}) : _dio = dio;

  /// 1. Получить общую статистику по мастеру (средний балл и распределение звёзд)
  Future<ReviewStatsModel> getMasterStats(int masterId) async {
    try {
      final response = await _dio.get('$baseUrl/masters/$masterId/stats');

      if (response.statusCode == 200) {
        return ReviewStatsModel.fromJson(response.data);
      } else {
        throw Exception(
          'Не удалось загрузить статистику: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Ошибка сети при получении статистики: ${e.message}');
    }
  }

  /// 2. Получить список отзывов о мастере с пагинацией (для бесконечной ленты)
  Future<List<ReviewModel>> getMasterReviews(
    int masterId, {
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await _dio.get(
        '$baseUrl/masters/$masterId',
        queryParameters: {
          'page': page,
          'size': size
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        return jsonList.map((json) => ReviewModel.fromJson(json)).toList();
      } else {
        throw Exception('Не удалось загрузить отзывы: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Ошибка сети при получении отзывов: ${e.message}');
    }
  }

  /// 3. Отправить новый отзыв на бэкенд
  Future<ReviewModel> createReview({
    required int masterId,
    required String clientName,
    required int rating,
    required String text,
  }) async {
    try {
      final response = await _dio.post(
        baseUrl,
        data: {
          'masterId': masterId,
          'clientName': clientName,
          'rating': rating,
          'text': text,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return ReviewModel.fromJson(response.data);
      } else {
        throw Exception('Не удалось сохранить отзыв: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Ошибка сети при отправке отзыва: ${e.message}');
    }
  }
}
