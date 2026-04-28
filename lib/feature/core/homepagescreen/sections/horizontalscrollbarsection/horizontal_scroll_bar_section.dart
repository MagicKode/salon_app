import 'package:flutter/material.dart';

class HorizontalScrollBarSection extends StatelessWidget {
  final List<PromoItem> items;

  const HorizontalScrollBarSection({Key? key, required this.items})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 134, // Общая высота компонента
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _PromoCard(item: items[index]),
          );
        },
      ),
    );
  }
}

// Модель данных для промо-элемента
class PromoItem {
  final String title;
  final String description;
  final String imageUrl;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  PromoItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    this.backgroundColor,
    this.onTap,
  });
}

// Карточка промо
class _PromoCard extends StatelessWidget {
  final PromoItem item;

  const _PromoCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        width: 343,
        height: 118,
        decoration: BoxDecoration(
          color: item.backgroundColor ?? Colors.blue[50],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Контент слева
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            // Изображение справа
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Image.network(
                item.imageUrl,
                width: 100,
                height: 118,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 118,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Пример использования:
class HorizontalScrollBarExample extends StatelessWidget {
  final List<PromoItem> demoItems = [
    PromoItem(
      title: 'Скидка 20%',
      description: 'На все услуги салона красоты',
      imageUrl: 'https://via.placeholder.com/100x118',
      backgroundColor: Colors.pink[50],
    ),
    PromoItem(
      title: 'Новый клиент',
      description: 'Первое посещение со скидкой 30%',
      imageUrl: 'https://via.placeholder.com/100x118',
      backgroundColor: Colors.blue[50],
    ),
    PromoItem(
      title: 'Подарок',
      description: 'При записи сегодня - маска для волос в подарок',
      imageUrl: 'https://via.placeholder.com/100x118',
      backgroundColor: Colors.green[50],
    ),
    PromoItem(
      title: 'Акция',
      description: 'Комплексный уход за полцены',
      imageUrl: 'https://via.placeholder.com/100x118',
      backgroundColor: Colors.purple[50],
    ),
    PromoItem(
      title: 'Спецпредложение',
      description: 'Маникюр + педикюр = 1990₽',
      imageUrl: 'https://via.placeholder.com/100x118',
      backgroundColor: Colors.orange[50],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.all(16)),
            HorizontalScrollBarSection(items: demoItems),
          ],
        ),
      ),
    );
  }
}
