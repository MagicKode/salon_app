import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/booking_service_screen.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import 'package:salon_flutter/uikit/widgets/card/servicecard/service_card.dart';

import '../../../../../config/theme/custom_colors.dart';
import '../../../../../uikit/widgets/dialog/add_service_dialog.dart';
import '../../../../catalog/data/models/service_dto.dart';
import '../../../../catalog/domain/repositories/catalog_repository.dart';
import '../../../catalogscreen/domain/catalog_service.dart';
import '../../../servicedetailscreen/domain/service_detail_data.dart';
import '../../../servicedetailscreen/service_detail_body.dart';

class ServiceGridSection extends StatefulWidget {
  final bool isMaster;
  final Function(CatalogService service)? onQuickBookRequested;
  final VoidCallback? onServiceUpdated;

  const ServiceGridSection({
    super.key,
    required this.isMaster,
    this.onQuickBookRequested,
    this.onServiceUpdated,
  });

  @override
  State<ServiceGridSection> createState() => _ServiceGridSectionState();
}

class _ServiceGridSectionState extends State<ServiceGridSection> {
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
      final allServices = await repo.getServices();
      setState(() {
        // Фильтруем удалённые услуги
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
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
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

      setState(() {
        _services.removeWhere((s) => s.id == service.id);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Услуга удалена из каталога')),
        );
        widget.onServiceUpdated?.call();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка удаления: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text('Ошибка: $_error'));
    }

    if (_services.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.ourServices,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              if (widget.isMaster)
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, size: 28),
                  color: colors.primaryBlue,
                  onPressed: () {
                    _showAddServiceSheet(context, widget.onServiceUpdated);
                  },
                ),
            ],
          ),
        ),
        SizedBox(
          height: 240,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemCount: _services.length,
            itemBuilder: (context, index) {
              final s = _services[index];
              return GestureDetector(
                onTap: () {
                  _showServiceDetails(context, s);
                },
                child: ServiceCard(
                  imageUrl: s.image?.url ?? '',
                  title: s.name,
                  subtitle: 'от ${s.price} Br',
                  showDeleteButton: widget.isMaster,
                  onDelete: widget.isMaster ? () => _deleteService(s) : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  Future<void> _showServiceDetails(BuildContext context, ServiceDto s) async {
    final detail = ServiceDetail(
      id: s.id.toString(),
      title: s.name,
      imageUrl: s.image?.url ?? '',
      duration: '${s.durationMinutes} мин',
      price: '${s.price} Br',
      description: s.description,
    );

    final selectedService = CatalogService(
      id: s.id.toString(),
      name: s.name,
      price: s.price,
      duration: '${s.durationMinutes} мин',
    );

    showModalBottomSheet<CatalogService>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => ServiceDetailBody(
            service: detail,
            isMaster: widget.isMaster,
            onServiceSelected: widget.onQuickBookRequested,
            onServiceUpdated: widget.onServiceUpdated,
            // ✅ Обработчик кнопки "Записаться"
            onBookPressed: () {
              // 1. Закрываем модалку (анимация вниз)
              Navigator.pop(context);
              // 2. Открываем экран бронирования с выбранной услугой
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => BookingServiceScreen(
                        selectedServices: [selectedService],
                      ),
                ),
              );
            },
          ),
    ).then((result) {
      if (result != null && context.mounted) {
        widget.onQuickBookRequested?.call(result);
      }
    });
  }

  void _showAddServiceSheet(
    BuildContext context,
    VoidCallback? onServiceUpdated,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddServiceSheet(onServiceAdded: onServiceUpdated),
    );
  }
}
