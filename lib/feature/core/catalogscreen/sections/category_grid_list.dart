import 'package:flutter/material.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../domain/catalog_category.dart';

class CategoryGridList extends StatelessWidget {
  final List<CatalogCategory> categories;
  final Function(CatalogCategory) onCategorySelected;

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
              // Оптимальная высота для красивой плитки
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              // ClipRRect нужен, чтобы картинка не вылезала за скругленные углы контейнера
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // 1. Задний фон — Фотография из ассетов
                    Positioned.fill(
                      child: Image.asset(
                        category.imagePath,
                        fit: BoxFit.cover,
                        // Растягиваем фото по всей плитке
                        // Заглушка на случай, если картинка еще не добавлена в pubspec.yaml
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.primaryBlue.withOpacity(0.2),
                            child: const Icon(
                              Icons.image_not_supported_rounded,
                              color: AppColors.primaryGrey,
                            ),
                          );
                        },
                      ),
                    ),

                    // 2. Градиентное затемнение поверх фото (чтобы текст не сливался с картинкой)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.black.withOpacity(0.65),
                              // Плотное затемнение слева под текст
                              Colors.black.withOpacity(0.1),
                              // Легкое затемнение справа для объема
                            ],
                          ),
                        ),
                      ),
                    ),

                    // 3. Контент плитки (Название зала)
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
                                // Белый текст поверх темного градиента
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${category.services.length} услуг',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.primaryWhite.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Иконка стрелочки вправо для индикации перехода
                    Positioned(
                      right: 20,
                      top: 0,
                      bottom: 0,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.primaryWhite.withOpacity(0.7),
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
