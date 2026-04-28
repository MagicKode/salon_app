import 'package:flutter/material.dart';

// Класс данных для категории услуги
class ServiceCategory {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback? onTap;

  const ServiceCategory({
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    this.onTap,
  });
}

// Класс для управления данными категорий услуг
class ServiceCategoryData {
  // Приватный конструктор чтобы нельзя было создать экземпляр класса
  ServiceCategoryData._();

  // Статические данные для услуг
  static const List<Map<String, dynamic>> _rawData = [
    {
      'title': 'Стрижка',
      'icon': Icons.content_cut,
      'backgroundColor': Color(0xFFE8F0FE), // Светло-голубой
      'iconColor': Colors.blue,
    },
    {
      'title': 'Маникюр',
      'icon': Icons.clean_hands,
      'backgroundColor': Color(0xFFFCE4E6), // Светло-розовый
      'iconColor': Colors.pink,
    },
    {
      'title': 'Педикюр',
      'icon': Icons.pedal_bike,
      'backgroundColor': Color(0xFFE8F5E9), // Светло-зеленый
      'iconColor': Colors.green,
    },
    {
      'title': 'Макияж',
      'icon': Icons.face,
      'backgroundColor': Color(0xFFFFF3E0), // Светло-оранжевый
      'iconColor': Colors.orange,
    },
    {
      'title': 'Брови',
      'icon': Icons.face_retouching_natural,
      'backgroundColor': Color(0xFFF3E5F5), // Светло-фиолетовый
      'iconColor': Colors.purple,
    },
    {
      'title': 'Ресницы',
      'icon': Icons.visibility,
      'backgroundColor': Color(0xFFE1F5FE), // Голубой
      'iconColor': Colors.teal,
    },
    {
      'title': 'СПА',
      'icon': Icons.spa,
      'backgroundColor': Color(0xFFE0F2F1), // Бирюзовый
      'iconColor': Colors.cyan,
    },
    {
      'title': 'Массаж',
      'icon': Icons.self_improvement,
      'backgroundColor': Color(0xFFFFF8E1), // Светло-желтый
      'iconColor': Colors.amber,
    },
  ];

  // Геттер для получения всех категорий
  static List<ServiceCategory> get allCategories {
    return _rawData.map((data) => _createCategory(data)).toList();
  }

  // Геттер для получения первой половины категорий (первые 4)
  static List<ServiceCategory> get firstHalf {
    return _rawData.take(4).map((data) => _createCategory(data)).toList();
  }

  // Геттер для получения второй половины категорий (последние 4)
  static List<ServiceCategory> get secondHalf {
    return _rawData.skip(4).take(4).map((data) => _createCategory(data)).toList();
  }

  // Получение категории по индексу
  static ServiceCategory? getCategoryByIndex(int index) {
    if (index >= 0 && index < _rawData.length) {
      return _createCategory(_rawData[index]);
    }
    return null;
  }

  // Получение категорий по рядам (для отображения в 2 ряда по 4)
  static List<List<ServiceCategory>> getCategoriesByRows() {
    return [
      allCategories.sublist(0, 4), // Первый ряд
      allCategories.sublist(4, 8), // Второй ряд
    ];
  }

  // Создание объекта ServiceCategory из сырых данных
  static ServiceCategory _createCategory(Map<String, dynamic> data) {
    return ServiceCategory(
      title: data['title'],
      icon: data['icon'],
      backgroundColor: data['backgroundColor'],
      iconColor: data['iconColor'],
      onTap: _getOnTapHandler(data['title']),
    );
  }

  // Получение обработчика нажатия
  static VoidCallback _getOnTapHandler(String title) {
    return () {
      debugPrint('Выбрана услуга: $title');
      // Здесь можно добавить разную логику для разных категорий
      switch (title) {
        case 'Стрижка':
        // Открыть страницу со стрижками
          break;
        case 'Маникюр':
        // Открыть страницу с маникюром
          break;
      // ... и так далее
      }
    };
  }

  // Поиск категорий по названию
  static List<ServiceCategory> searchCategories(String query) {
    if (query.isEmpty) return allCategories;

    return allCategories.where((category) {
      return category.title.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Фильтрация категорий по цвету фона
  static List<ServiceCategory> getCategoriesByBackgroundColor(Color color) {
    return allCategories.where((category) {
      return category.backgroundColor == color;
    }).toList();
  }
}