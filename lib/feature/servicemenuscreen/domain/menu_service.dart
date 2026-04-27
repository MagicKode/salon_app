class MenuService {
  final String id;
  final String title;
  final String price;
  final String? oldPrice;
  final String duration;
  final String description;
  final String imageUrl;
  final String? discount;
  final bool isInCart;

  const MenuService({
    required this.id,
    required this.title,
    required this.price,
    this.oldPrice,
    required this.duration,
    required this.description,
    required this.imageUrl,
    this.discount,
    this.isInCart = false,
  });
}
