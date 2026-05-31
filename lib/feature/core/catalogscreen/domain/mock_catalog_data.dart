import 'catalog_category.dart';
import 'catalog_service.dart';

abstract class MockCatalogData {
  static const List<CatalogCategory> categories = [
    CatalogCategory(
      id: 'cat_1',
      name: 'Мужской зал',
      imagePath: 'assets/images/services/man/man-style.jpg',
      services: [
        CatalogService(id: 's_1', name: 'Мужская классическая стрижка', price: 35.0, duration: '45 мин.'),
        CatalogService(id: 's_2', name: 'Стрижка бороды и усов', price: 20.0, duration: '30 мин.'),
        CatalogService(id: 's_3', name: 'Комплекс (Стрижка + Борода)', price: 50.0, duration: '1 ч. 15 мин.'),
      ],
    ),
    CatalogCategory(
      id: 'cat_2',
      name: 'Женский зал',
      imagePath: 'assets/images/services/woman/woman-style.jpg',
      services: [
        CatalogService(id: 's_4', name: 'Женская стрижка (короткие волосы)', price: 45.0, duration: '1 ч.'),
        CatalogService(id: 's_5', name: 'Женская стрижка (длинные волосы)', price: 60.0, duration: '1 ч. 30 мин.'),
        CatalogService(id: 's_6', name: 'Ровный срез', price: 25.0, duration: '20 мин.'),
      ],
    ),
    CatalogCategory(
      id: 'cat_3',
      name: 'Окрашивание и уход',
      imagePath: 'assets/images/services/woman/woman-brows.jpeg',
      services: [
        CatalogService(id: 's_7', name: 'Мужское окрашивание камуфляж', price: 30.0, duration: '40 мин.'),
        CatalogService(id: 's_8', name: 'Сложное женское окрашивание', price: 150.0, duration: '3 ч.'),
        CatalogService(id: 's_9', name: 'Восстанавливающий уход за волосами', price: 55.0, duration: '1 ч.'),
      ],
    ),
  ];
}
