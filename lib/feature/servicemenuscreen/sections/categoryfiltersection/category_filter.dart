import 'package:flutter/material.dart';

import '../../domain/service_menu_category.dart';


class CategoryFilter extends StatelessWidget {
  final List<ServiceMenuCategory> categories;
  const CategoryFilter({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isSelected = index == 0; // Для примера первая активна
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: isSelected ? [const BoxShadow(color: Colors.black12, blurRadius: 4)] : null,
            ),
            child: Row(
              children: [
                Icon(categories[index].icon, size: 18, color: isSelected ? const Color(0xFF4CA6A8) : Colors.grey),
                const SizedBox(width: 8),
                Text(categories[index].title, style: TextStyle(fontWeight: FontWeight.w500, color: isSelected ? Colors.black : Colors.grey)),
              ],
            ),
          );
        },
      ),
    );
  }
}