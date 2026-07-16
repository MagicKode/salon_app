import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов
import '../../../feature/catalog/data/models/category_dto.dart';
import '../../../feature/catalog/data/models/service_dto.dart';
import '../../../feature/catalog/domain/repositories/catalog_repository.dart';
import '../../../feature/core/catalogscreen/domain/catalog_service.dart';

class ServiceListBottomSheet extends StatelessWidget {
  final CategoryDto category;
  final List<CatalogService> selectedServices;
  final Function(CatalogService) onServiceSelected;

  const ServiceListBottomSheet({
    super.key,
    required this.category,
    required this.selectedServices,
    required this.onServiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    final repo = context.read<CatalogRepository>();

    return FutureBuilder<List<ServiceDto>>(
      future: repo.getServicesByCategory(category.id),
      builder: (context, snapshot) {
        // ✅ Получаем динамические цвета внутри билдера
        final colors = Theme.of(context).extension<CustomColors>()!;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(height: 12),
                Text(
                  'Загрузка услуг...',
                  style: TextStyle(
                    color: colors.textSecondary, // ✅ динамический серый
                  ),
                ),
              ],
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(32),
            child: Text(
              'Ошибка загрузки услуг',
              style: TextStyle(color: colors.statusError), // ✅ динамический красный
            ),
          );
        }

        final services = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Полосочка-индикатор
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.divider, // ✅ динамическая граница
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Заголовок категории
              Text(
                category.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary, // ✅ динамический цвет текста
                ),
              ),
              const SizedBox(height: 16),

              // Список услуг
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: services.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    color: colors.divider,
                  ),
                  itemBuilder: (context, index) {
                    final s = services[index];
                    final catalogService = CatalogService(
                      id: s.id.toString(),
                      name: s.name,
                      price: s.price,
                      duration: '${s.durationMinutes} мин',
                    );
                    final isSelected = selectedServices.contains(
                      catalogService,
                    );

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  s.name,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: colors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${s.durationMinutes} мин',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${s.price} Br',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: colors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                height: 32,
                                child: ElevatedButton(
                                  onPressed: () => onServiceSelected(catalogService),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isSelected
                                        ? colors.surfaceInput
                                        : colors.primaryBlue,
                                    foregroundColor: isSelected
                                        ? colors.textPrimary
                                        : colors.textOnPrimary,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    isSelected ? 'Убрать' : 'Выбрать',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
