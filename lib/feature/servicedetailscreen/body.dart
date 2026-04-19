import 'package:flutter/material.dart';

import 'domain/ServiceDetail.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // Демо-данные (позже будут передаваться через конструктор)
  final service = const ServiceDetail(
    title: 'Мужская стрижка "Fade"',
    imageUrl:
        'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?q=80&w=1000&auto=format&fit=crop',
    duration: '45-60 мин',
    price: '30 BYN',
    description:
        'Классическая техника стрижки с плавным переходом от коротких волос на затылке до любой желаемой длины на макушке. В стоимость включено мытье головы и укладка профессиональными средствами.',
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Основной контент
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Половина экрана - фото
              Container(
                height: size.height * 0.45, // Примерно половина (45%)
                width: double.infinity,
                child: Hero(
                  tag: 'service_image', // Анимация перехода, если нужно
                  child: Image.network(service.imageUrl, fit: BoxFit.cover),
                ),
              ),

              // 2. Вторая половина - инфо
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
                // Большой отступ снизу под кнопку
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Наименование
                    Text(
                      service.title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Время оказания
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 18,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          service.duration,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Цена
                    Text(
                      service.price,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF093882), // Ваш синий цвет
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Описание сервиса
                    const Text(
                      'Описание',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      service.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Кнопка назад (так как appBar в Scaffold пустой)
        Positioned(
          top: 40,
          left: 16,
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.8),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),

        // 3. Кнопка "Забронировать" внизу
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: ElevatedButton(
            onPressed: () {
              print('Переход на бронирование...');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF093882),
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
            ),
            child: const Text(
              'Забронировать',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
