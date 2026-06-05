abstract class ReviewEvent {}

class ReviewFetchRequested extends ReviewEvent {
  final int masterId;
  ReviewFetchRequested(this.masterId);
}

class ReviewCreateRequested extends ReviewEvent {
  final int masterId;
  final int rating;
  final String clientName;
  final String text;

  ReviewCreateRequested({
    required this.masterId,
    required this.rating,
    required this.clientName,
    required this.text,
  });
}
