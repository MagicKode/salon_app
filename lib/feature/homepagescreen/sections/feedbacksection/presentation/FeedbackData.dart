// В новом файле или в этом же
import '../data/entities/FeedbackItem.dart';

class FeedbackData {
  static final List<FeedbackItem> items = [
    FeedbackItem(
      userName: 'Марина И.',
      rating: 5,
      comment: 'Прекрасный мастер! Сделали именно то, что я хотела. Уютная атмосфера.',
      date: 'вчера',
    ),
    FeedbackItem(
      userName: 'Алексей',
      rating: 4,
      comment: 'Стрижка отличная, но пришлось подождать 10 минут. В остальном все супер!',
      date: '2 дня назад',
    ),
    FeedbackItem(
      userName: 'Елена С.',
      rating: 5,
      comment: 'Лучший маникюр в моей жизни! Очень аккуратно и красиво.',
      date: '05.04.2026',
    ),
  ];
}