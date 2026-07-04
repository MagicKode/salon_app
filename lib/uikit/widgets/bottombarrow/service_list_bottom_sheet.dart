import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../feature/catalog/data/models/category_dto.dart';
import '../../../feature/catalog/data/models/service_dto.dart';
import '../../../feature/catalog/domain/repositories/catalog_repository.dart';
import '../../../feature/core/catalogscreen/domain/catalog_service.dart';
import '../../colors/app_colors.dart';

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
        // Пока данные грузятся – показываем компактный индикатор
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(height: 12),
                Text(
                  'Загрузка услуг...',
                  style: TextStyle(color: AppColors.primaryGrey),
                ),
              ],
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.all(32),
            child: Text('Ошибка загрузки услуг'),
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
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Заголовок категории
              Text(
                category.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Список услуг (динамическая высота)
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: services.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
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
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${s.durationMinutes} мин',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primaryGrey,
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
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                height: 32,
                                child: ElevatedButton(
                                  onPressed:
                                      () => onServiceSelected(catalogService),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isSelected
                                            ? Colors.grey.shade200
                                            : AppColors.primaryBlue,
                                    foregroundColor:
                                        isSelected
                                            ? AppColors.primaryBlack
                                            : AppColors.primaryWhite,
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
