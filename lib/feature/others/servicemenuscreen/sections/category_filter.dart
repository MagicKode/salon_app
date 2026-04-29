import 'package:flutter/material.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../domain/menu_service.dart';

class CategoryFilter extends StatelessWidget {
  final List<ServiceMenuCategory> categories;
  final int selectedIndex; // Добавили индекс
  const CategoryFilter({super.key, required this.categories, this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return AnimatedContainer( // Добавили анимацию для красоты
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryBlue : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isSelected ? AppColors.primaryBlue : Colors.grey.shade300),
            ),
            child: Center(
              child: Text(
                categories[index].title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
