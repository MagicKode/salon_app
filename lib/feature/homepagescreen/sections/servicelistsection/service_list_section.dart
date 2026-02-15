import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/homepagescreen/sections/servicelistsection/servicecategory.dart';

class ServiceListSection extends StatelessWidget {
  final List<ServiceCategory>? customCategories;
  final Function(ServiceCategory)? onCategoryTap;

  const ServiceListSection({
    Key? key,
    this.customCategories,
    this.onCategoryTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = customCategories ?? ServiceCategoryData.allCategories;
    final rows = _splitIntoRows(categories);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Заголовок секции
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Выберите услугу',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Сетка услуг
        Container(
          height: 260,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // Первый ряд
              _buildServiceRow(rows[0]),
              const SizedBox(height: 16),
              // Второй ряд
              if (rows.length > 1) _buildServiceRow(rows[1]),
            ],
          ),
        ),
      ],
    );
  }

  // Разделение списка на ряды по 4 элемента
  List<List<ServiceCategory>> _splitIntoRows(List<ServiceCategory> categories) {
    final List<List<ServiceCategory>> rows = [];
    for (var i = 0; i < categories.length; i += 4) {
      final end = (i + 4 < categories.length) ? i + 4 : categories.length;
      rows.add(categories.sublist(i, end));
    }
    return rows;
  }

  // Построение ряда с услугами
  Widget _buildServiceRow(List<ServiceCategory> services) {
    return SizedBox(
      height: 91,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: services.map((service) => _buildServiceItem(service)).toList(),
      ),
    );
  }

  // Построение отдельного элемента услуги
  Widget _buildServiceItem(ServiceCategory service) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: service.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (onCategoryTap != null) {
                onCategoryTap!(service);
              } else if (service.onTap != null) {
                service.onTap!();
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    service.icon,
                    color: service.iconColor,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  service.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}