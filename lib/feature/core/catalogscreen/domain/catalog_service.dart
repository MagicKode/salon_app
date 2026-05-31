class CatalogService {
  final String id;
  final String name;
  final double price;
  final String duration; // Например, "1 ч. 30 мин."

  const CatalogService({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
  });
}


