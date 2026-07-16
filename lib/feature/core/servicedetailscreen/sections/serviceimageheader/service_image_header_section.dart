import 'package:flutter/material.dart';
import '../../../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов
import '../../domain/service_detail_data.dart';

class ServiceImageHeaderSection extends StatelessWidget {
  final ServiceDetail service;

  const ServiceImageHeaderSection({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

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
                  color: colors.surfaceInput, // ✅ динамический фон заглушки
                  child: Icon(
                    Icons.image_not_supported_rounded,
                    color: colors.textSecondary, // ✅ динамический серый
                    size: 48,
                  ),
                ),
              ),
            ),
          ),

          // 2. Градиент поверх картинки (остаётся тёмным, не зависит от темы)
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
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // 3. Текст заголовка (всегда белый на тёмном фоне)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                service.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Кнопка "закрыть" (всегда белая)
          Positioned(
            top: 12,
            left: 12,
            child: IconButton(
              icon: const Icon(
                Icons.expand_more,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // 5. Серый индикатор (handle) по центру (полупрозрачный белый)
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
