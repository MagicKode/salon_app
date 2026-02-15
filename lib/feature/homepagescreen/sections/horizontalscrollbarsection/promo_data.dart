import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/homepagescreen/sections/horizontalscrollbarsection/horizontal_scroll_bar_section.dart';

class PromoData {
  // Приватный конструктор чтобы нельзя было создать экземпляр класса
  PromoData._();

  // Статические данные для промо-акций
  static const List<Map<String, dynamic>> _promoItemsData = [
    {
      'title': 'Скидка 20%',
      'description': 'На все услуги салона красоты',
      'imageUrl': 'https://via.placeholder.com/100x118',
      'backgroundColor': 'pink',
    },
    {
      'title': 'Новый клиент',
      'description': 'Первое посещение со скидкой 30%',
      'imageUrl': 'https://via.placeholder.com/100x118',
      'backgroundColor': 'blue',
    },
    {
      'title': 'Подарок',
      'description': 'При записи сегодня - маска для волос в подарок',
      'imageUrl': 'https://via.placeholder.com/100x118',
      'backgroundColor': 'green',
    },
    {
      'title': 'Акция',
      'description': 'Комплексный уход за полцены',
      'imageUrl': 'https://via.placeholder.com/100x118',
      'backgroundColor': 'purple',
    },
    {
      'title': 'Спецпредложение',
      'description': 'Маникюр + педикюр = 1990₽',
      'imageUrl': 'https://via.placeholder.com/100x118',
      'backgroundColor': 'orange',
    },
  ];

  // Геттер для получения списка PromoItem
  static List<PromoItem> get promoItems {
    return _promoItemsData.map((item) => _createPromoItem(item)).toList();
  }

  // Создание PromoItem из данных
  static PromoItem _createPromoItem(Map<String, dynamic> data) {
    return PromoItem(
      title: data['title'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      backgroundColor: _getBackgroundColor(data['backgroundColor']),
      onTap: _getOnTapHandler(data['title']),
    );
  }

  // Получение цвета фона по строковому ключу
  static Color? _getBackgroundColor(String colorKey) {
    switch (colorKey) {
      case 'pink':
        return Colors.pink[50];
      case 'blue':
        return Colors.blue[50];
      case 'green':
        return Colors.green[50];
      case 'purple':
        return Colors.purple[50];
      case 'orange':
        return Colors.orange[50];
      default:
        return Colors.grey[50];
    }
  }

  // Получение обработчика нажатия (можно расширить логику)
  static VoidCallback? _getOnTapHandler(String title) {
    return () {
      // Здесь можно добавить логику для разных типов промо
      debugPrint('Нажата промо-акция: $title');
      // Можно возвращать разные обработчики в зависимости от title
    };
  }

  // Альтернативный метод для получения только определенного количества элементов
  static List<PromoItem> getPromoItems({int? limit}) {
    if (limit == null || limit >= _promoItemsData.length) {
      return promoItems;
    }
    return _promoItemsData.take(limit).map((item) => _createPromoItem(item)).toList();
  }

  // Метод для получения элемента по индексу
  static PromoItem? getPromoItemByIndex(int index) {
    if (index >= 0 && index < _promoItemsData.length) {
      return _createPromoItem(_promoItemsData[index]);
    }
    return null;
  }
}