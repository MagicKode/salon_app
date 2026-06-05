class ReviewStatsModel {
  final double averageRating;
  final int totalReviews;
  final int star5Count;
  final int star4Count;
  final int star3Count;
  final int star2Count;
  final int star1Count;

  ReviewStatsModel({
    required this.averageRating,
    required this.totalReviews,
    required this.star5Count,
    required this.star4Count,
    required this.star3Count,
    required this.star2Count,
    required this.star1Count,
  });

  factory ReviewStatsModel.fromJson(Map<String, dynamic> json) {
    return ReviewStatsModel(
      averageRating: (json['averageRating'] as num).toDouble(),
      totalReviews: json['totalReviews'] as int,
      star5Count: json['star5Count'] as int,
      star4Count: json['star4Count'] as int,
      star3Count: json['star3Count'] as int,
      star2Count: json['star2Count'] as int,
      star1Count: json['star1Count'] as int,
    );
  }
}
