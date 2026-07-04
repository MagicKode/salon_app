class ServiceItemData {
  final String title;
  final String subtitle;
  final String imageUrl;    // сетевой URL из БД
  final String detailImageUrl; // большое фото для экрана деталей
  final String category;    // 'man' или 'woman'
  final List<String> services;
  final List<int> prices;
  final List<int> durations;

  const ServiceItemData({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.detailImageUrl,
    required this.category,
    required this.services,
    required this.prices,
    required this.durations,
  });
}
