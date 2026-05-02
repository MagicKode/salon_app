import 'package:flutter/material.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../domain/service_detail_data.dart';

class ServiceImageHeaderSection extends StatelessWidget {
  final ServiceDetail service;

  const ServiceImageHeaderSection({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      // Оставляем скругление здесь
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        image: DecorationImage(
          image: NetworkImage(service.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // 2. Градиент поверх картинки
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              ),
            ),
          ),
          // 3. Текст заголовка
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                service.title,
                style: const TextStyle(
                  color: AppColors.primaryWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Кнопка "закрыть"
          Positioned(
            top: 12,
            left: 12,
            child: IconButton(
              icon: const Icon(
                Icons.expand_more,
                color: AppColors.primaryWhite,
                size: 32,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
