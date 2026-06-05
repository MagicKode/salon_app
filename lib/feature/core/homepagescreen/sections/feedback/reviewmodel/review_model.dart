class ReviewModel {
  final int id;
  final int masterId;
  final String clientName;
  final int rating;
  final String text;
  final DateTime createdAt;

  ReviewModel({
    required this.id,
    required this.masterId,
    required this.clientName,
    required this.rating,
    required this.text,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as int,
      masterId: json['masterId'] as int,
      clientName: json['clientName'] as String,
      rating: json['rating'] as int,
      text: json['text'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
