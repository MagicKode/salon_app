class FeedbackItem {
  final String userName;
  final double rating; // 0.0 - 5.0
  final String comment;
  final String date;

  const FeedbackItem({
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });
}