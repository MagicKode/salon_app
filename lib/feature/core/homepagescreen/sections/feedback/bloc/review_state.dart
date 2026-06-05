import '../reviewmodel/review_model.dart';
import '../reviewmodel/review_stats_model.dart';

abstract class ReviewState {}

class ReviewInitial extends ReviewState {}
class ReviewLoading extends ReviewState {}

class ReviewSuccess extends ReviewState {
  final ReviewStatsModel stats;
  final List<ReviewModel> reviews;
  ReviewSuccess({required this.stats, required this.reviews});
}

class ReviewFailure extends ReviewState {
  final String errorMessage;
  ReviewFailure(this.errorMessage);
}
