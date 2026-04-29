import 'package:flutter/material.dart';

import '../domain/home_models.dart';

class ServiceGridSection extends StatelessWidget {
  const ServiceGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: ServiceData.categories.length,
      itemBuilder:
          (context, index) =>
              _ServiceItem(category: ServiceData.categories[index]),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  final ServiceCategory category;

  const _ServiceItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: category.backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(category.icon, color: category.iconColor, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          category.title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
