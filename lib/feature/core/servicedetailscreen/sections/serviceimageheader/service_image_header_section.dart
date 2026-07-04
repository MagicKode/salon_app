import 'package:flutter/material.dart';

import '../../../../../uikit/colors/app_colors.dart';
import '../../domain/service_detail_data.dart';

class ServiceImageHeaderSection extends StatelessWidget {
  final ServiceDetail service;

  const ServiceImageHeaderSection({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: double.infinity,
      child: Stack(
        children: [
          // 1. Сама картинка с ClipRRect для соблюдения радиуса
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.network(
                service.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported_rounded, color: AppColors.primaryGrey, size: 48),
                ),
              ),
            ),
          ),

          // 2. Градиент поверх картинки
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primaryBlack.withValues(alpha: 0.3),
                    Colors.transparent,
                    AppColors.primaryBlack.withValues(alpha: 0.8),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
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

          // 5. Тот самый серый индикатор (handle) по центру
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.primaryWhite.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
