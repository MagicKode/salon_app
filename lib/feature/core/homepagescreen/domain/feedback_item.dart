class FeedbackItem {
  final String userName;
  final double rating;
  final String comment;
  final String date;
  const FeedbackItem({required this.userName, required this.rating, required this.comment, required this.date});
}

class FeedbackData {
  static const List<FeedbackItem> items = [
    FeedbackItem(
      userName: 'Марина И.',
      rating: 5,
      comment: 'Прекрасный мастер! Сделали именно то, что я хотела.',
      date: 'вчера',
    ),
    FeedbackItem(
      userName: 'Алексей',
      rating: 4.5,
      comment: 'Стрижка отличная, все супер!',
      date: '2 дня назад',
    ),
  ];
}
