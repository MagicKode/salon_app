class BottomBarItemData {
  final String id;
  final String name;
  final double price;

  const BottomBarItemData({
    required this.id,
    required this.name,
    required this.price,
  });

  // SOLID: Сюда же можно вынести иммутабельный метод копирования, если в будущем данные будут меняться
  BottomBarItemData copyWith({
    String? id,
    String? name,
    double? price,
  }) {
    return BottomBarItemData(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }
}