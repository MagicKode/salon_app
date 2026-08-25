import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/theme/custom_colors.dart';
import '../../../feature/catalog/data/models/category_dto.dart';
import '../../../feature/catalog/data/models/service_dto.dart';
import '../../../feature/catalog/domain/repositories/catalog_repository.dart';
import '../../../feature/core/catalogscreen/domain/catalog_service.dart';

class ServiceListBottomSheet extends StatefulWidget {
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
  State<ServiceListBottomSheet> createState() => _ServiceListBottomSheetState();
}

class _ServiceListBottomSheetState extends State<ServiceListBottomSheet> {
  List<ServiceDto> _services = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    try {
      final repo = context.read<CatalogRepository>();
      final allServices = await repo.getServicesByCategory(widget.category.id);
      // Фильтруем удалённые (на случай, если API вернёт их)
      setState(() {
        _services = allServices.where((s) => !s.isDeleted).toList();
        _isLoading = false;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  Future<void> _deleteService(ServiceDto service) async {
    // Диалог подтверждения
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Удалить услугу?'),
            content: Text('Вы уверены, что хотите удалить "${service.name}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Отмена'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Удалить', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );

    if (confirm != true) return;

    try {
      final repo = context.read<CatalogRepository>();
      await repo.softDeleteService(service.id);

      // Удаляем услугу из локального списка
      setState(() {
        _services.removeWhere((s) => s.id == service.id);
      });

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Услуга удалена из каталога')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка удаления: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    if (_isLoading) {
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
              style: TextStyle(color: colors.textSecondary),
            ),
          ],
        ),
      );
    }

    if (_error != null || _services.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: colors.statusError),
            const SizedBox(height: 12),
            Text(
              _error != null
                  ? 'Ошибка загрузки услуг'
                  : 'Нет услуг в этой категории',
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.textSecondary),
            ),
          ],
        ),
      );
    }

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
                color: colors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Заголовок категории
          Text(
            widget.category.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          // Список услуг
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _services.length,
              separatorBuilder:
                  (_, __) => Divider(height: 1, color: colors.divider),
              itemBuilder: (context, index) {
                final s = _services[index];
                final catalogService = CatalogService(
                  id: s.id.toString(),
                  name: s.name,
                  price: s.price,
                  duration: '${s.durationMinutes} мин',
                );
                final isSelected = widget.selectedServices.contains(
                  catalogService,
                );

                return Stack(
                  children: [
                    // Основная карточка
                    Padding(
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
                                  onPressed:
                                      () => widget.onServiceSelected(
                                        catalogService,
                                      ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isSelected
                                            ? colors.surfaceInput
                                            : colors.primaryBlue,
                                    foregroundColor:
                                        isSelected
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
                    ),
                    // Крестик удаления (в правом верхнем углу)
                    Positioned(
                      top: 4,
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          size: 18,
                          color: colors.textHint.withOpacity(0.6),
                        ),
                        onPressed: () => _deleteService(s),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        splashRadius: 20,
                        tooltip: 'Удалить услугу',
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
