import 'package:flutter/material.dart';

import '../domain/menu_service.dart';

class ServiceMenuCard extends StatelessWidget {
  final MenuService service;

  const ServiceMenuCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Фиксированная картинка
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              service.imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "${service.price} • ${service.duration}",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Text(
                  service.description,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Icon(
            service.isInCart ? Icons.remove_circle_outline : Icons.add_circle,
            color:
                service.isInCart ? Colors.redAccent : const Color(0xFF1D4D4F),
            size: 30,
          ),
        ],
      ),
    );
  }
}
