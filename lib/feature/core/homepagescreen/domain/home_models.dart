import 'package:flutter/material.dart';

// Одна модель для Категорий
class ServiceCategory {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  const ServiceCategory({required this.title, required this.icon, required this.backgroundColor, required this.iconColor});
}

// Одна модель для Отзывов
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

class ServiceData {
  static const List<ServiceCategory> categories = [
    ServiceCategory(title: 'Стрижка', icon: Icons.content_cut, backgroundColor: Color(0xFFE8F0FE), iconColor: Colors.blue),
    ServiceCategory(title: 'Маникюр', icon: Icons.clean_hands, backgroundColor: Color(0xFFFCE4E6), iconColor: Colors.pink),
    ServiceCategory(title: 'Педикюр', icon: Icons.spa, backgroundColor: Color(0xFFE8F5E9), iconColor: Colors.green),
    ServiceCategory(title: 'Макияж', icon: Icons.face, backgroundColor: Color(0xFFFFF3E0), iconColor: Colors.orange),
    ServiceCategory(title: 'Брови', icon: Icons.remove_red_eye, backgroundColor: Color(0xFFF3E5F5), iconColor: Colors.purple),
    ServiceCategory(title: 'Ресницы', icon: Icons.visibility, backgroundColor: Color(0xFFE1F5FE), iconColor: Colors.teal),
    ServiceCategory(title: 'СПА', icon: Icons.hot_tub, backgroundColor: Color(0xFFE0F2F1), iconColor: Colors.cyan),
    ServiceCategory(title: 'Массаж', icon: Icons.self_improvement, backgroundColor: Color(0xFFFFF8E1), iconColor: Colors.amber),
  ];
}

// Одна модель для Промо
// class PromoItem {
//   final String title;
//   final String description;
//   final String imageUrl;
//   final Color backgroundColor;
//   const PromoItem({required this.title, required this.description, required this.imageUrl, required this.backgroundColor});
// }

// class PromoData {
//   static const List<PromoItem> items = [
//     PromoItem(
//       title: 'Скидка 20%',
//       description: 'На все услуги салона красоты',
//       imageUrl: 'https://via.placeholder.com/100x118',
//       backgroundColor: Color(0xFFFFE4E6),
//     ),
//     PromoItem(
//       title: 'Новый клиент',
//       description: 'Первое посещение со скидкой 30%',
//       imageUrl: 'https://via.placeholder.com/100x118',
//       backgroundColor: Color(0xFFE0F2FE),
//     ),
//   ];
// }