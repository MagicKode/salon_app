import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/review_api_service.dart';
import '../reviewmodel/review_model.dart';
import '../reviewmodel/review_stats_model.dart';
import 'review_event.dart';
import 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewApiService _apiService;

  ReviewBloc(this._apiService) : super(ReviewInitial()) {

    on<ReviewFetchRequested>((event, emit) async {
      emit(ReviewLoading());
      try {
        // Параллельно запрашиваем и стату, и список отзывов
        final results = await Future.wait([
          _apiService.getMasterStats(event.masterId),
          _apiService.getMasterReviews(event.masterId),
        ]);

        emit(
          ReviewSuccess(
            stats: results[0] as ReviewStatsModel,
            reviews: results[1] as List<ReviewModel>,
          ),
        );
      } catch (e) {
        emit(ReviewFailure(e.toString()));
      }
    });

    // ХЭНДЛЕР 2: Ловим создание отзыва
    on<ReviewCreateRequested>((event, emit) async {
      try {
        // 1. Стучимся на бэк и сохраняем отзыв
        await _apiService.createReview(
          masterId: event.masterId,
          clientName: event.clientName,
          rating: event.rating,
          text: event.text,
        );

        // 2. Прямо отсюда вызываем Хэндлер 1 (загрузку) заново!
        add(ReviewFetchRequested(event.masterId));
      } catch (e) {
        emit(ReviewFailure(e.toString()));
      }
    });
  }
}
