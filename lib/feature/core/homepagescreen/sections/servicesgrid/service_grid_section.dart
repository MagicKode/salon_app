import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/servicesgrid/service_item.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../catalog/data/models/catalog_image.dart';
import '../../../../catalog/data/models/service_dto.dart';
import '../../../../catalog/domain/repositories/catalog_repository.dart';
import '../../../catalogscreen/domain/catalog_service.dart';
import '../../../servicedetailscreen/domain/service_detail_data.dart';
import '../../../servicedetailscreen/service_detail_body.dart';
import '../../domain/service_item_data.dart';

class ServiceGridSection extends StatelessWidget {
  final bool isMaster;
  final Function(CatalogService service)? onQuickBookRequested;

  const ServiceGridSection({
    super.key,
    required this.isMaster,
    this.onQuickBookRequested,
  });

  Future<List<ServiceItemData>> _loadServices(BuildContext context) async {
    final repo = context.read<CatalogRepository>();
    final List<CatalogImage> images = await repo.getImages('service', 0);

    // Пока у нас нет реальной таблицы услуг, мы создадим ServiceItemData вручную,
    // связывая изображения с предопределёнными названиями услуг.
    // В будущем это будет приходить с сервера.
    final List<ServiceItemData> services = [];

    // Пример для мужских услуг (первые 4 изображения)
    if (images.length >= 4) {
      services.addAll([
        ServiceItemData(
          title: 'Мужская стрижка',
          subtitle: 'от 25 Br',
          imageUrl: images[0].url,
          detailImageUrl: images[0].url,
          category: 'man',
          services: ['Мужская стрижка'],
          prices: [25],
          durations: [60],
        ),
        ServiceItemData(
          title: 'Мужское окрашивание',
          subtitle: 'от 80 Br',
          imageUrl: images[1].url,
          detailImageUrl: images[1].url,
          category: 'man',
          services: ['Мужское окрашивание'],
          prices: [80],
          durations: [120],
        ),
        // добавьте остальные
      ]);
    }

    // Женские услуги (следующие 4 изображения)
    if (images.length >= 8) {
      services.addAll([
        ServiceItemData(
          title: 'Женская стрижка',
          subtitle: 'от 30 Br',
          imageUrl: images[4].url,
          detailImageUrl: images[4].url,
          category: 'woman',
          services: ['Женская стрижка'],
          prices: [30],
          durations: [60],
        ),
        // остальные...
      ]);
    }

    return services;
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.read<CatalogRepository>();
    return FutureBuilder<List<ServiceDto>>(
      future: repo.getServices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        }
        final services = snapshot.data ?? [];
        if (services.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Text(
                AppStrings.ourServices,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final category = services[index];
                  final s = services[index];
                  return GestureDetector(
                    onTap: () {
                      // Открытие деталей услуги (пока с прежней логикой)
                      _showServiceDetails(context, s);
                    },
                    child: ServiceItem(
                      imageUrl: s.image?.url ?? '',
                      title: s.name,
                      subtitle: 'от ${s.price} Br',
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
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

    showModalBottomSheet<CatalogService>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ServiceDetailBody(
        service: detail,
        isMaster: isMaster,
      ),
    ).then((result) {
      if (result != null && context.mounted) {
        onQuickBookRequested?.call(result);
      }
    });
  }
}
