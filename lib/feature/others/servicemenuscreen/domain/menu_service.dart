import 'package:flutter/material.dart';

class ServiceMenuCategory {
  final String title;
  final IconData icon;
  const ServiceMenuCategory({required this.title, required this.icon});
}

class MenuService {
  final String id;
  final String title;
  final String price;
  final String duration;
  final String description;
  final String imageUrl;
  final String? discount;
  final bool isInCart;

  const MenuService({
    required this.id,
    required this.title,
    required this.price,
    required this.duration,
    required this.description,
    required this.imageUrl,
    this.discount,
    this.isInCart = false,
  });
}

// Выносим константы данных
class MenuData {
  static const List<ServiceMenuCategory> categories = [
    ServiceMenuCategory(title: "Haircut", icon: Icons.content_cut),
    ServiceMenuCategory(title: "Facial", icon: Icons.face),
    ServiceMenuCategory(title: "Nails", icon: Icons.brush),
  ];

  static const MenuService mockService = MenuService(
    id: '1',
    title: "Woman Blunt Cut",
    price: "50 BYN",
    duration: "2 hour",
    description: "A blunt cut bob is a shorter hairstyle that's cut into a straight line.",
    imageUrl: "https://images.unsplash.com/photo-1562322140-8baeececf3df?q=80&w=200",
    isInCart: true,
  );
}
