import 'package:flutter/material.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../../../uikit/widgets/card/networkimagewithplaceholder.dart';
import '../../../catalog/data/models/category_dto.dart';

class CategoryGridList extends StatelessWidget {
  final List<CategoryDto> categories;
  final Function(CategoryDto) onCategorySelected;

  const CategoryGridList({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: GestureDetector(
            onTap: () => onCategorySelected(category),
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // Фото категории из сети
                    Positioned.fill(
                      child: category.image != null
                          ? NetworkImageWithPlaceholder(
                        url: category.image!.url,
                        fit: BoxFit.cover,
                        errorWidget: Container(
                          color: AppColors.primaryBlue.withValues(alpha: 0.2),
                          child: const Icon(Icons.image_not_supported_rounded, color: AppColors.primaryGrey),
                        ),
                      )
                          : Container(
                        color: AppColors.primaryBlue.withValues(alpha: 0.2),
                        child: const Icon(Icons.image_not_supported_rounded, color: AppColors.primaryGrey),
                      ),
                    ),
                    // Градиент
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.black.withValues(alpha: 0.65),
                              Colors.black.withValues(alpha: 0.1),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Название
                    Positioned(
                      left: 20,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryWhite,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Услуги',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.primaryWhite.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Стрелка
                    Positioned(
                      right: 20,
                      top: 0,
                      bottom: 0,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.primaryWhite.withValues(alpha: 0.7),
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
