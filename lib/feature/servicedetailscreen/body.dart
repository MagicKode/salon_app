import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/servicedetailscreen/sections/ServiceDescriptionSection.dart';
import 'package:salon_flutter/feature/servicedetailscreen/sections/ServiceImageHeaderSection.dart';
import 'package:salon_flutter/feature/servicedetailscreen/sections/ServiceInfoSection.dart';
import 'domain/ServiceDetail.dart';

class Body extends StatelessWidget {
  // Данные (обычно приходят из BLoC/Provider или конструктора)
  final service = const ServiceDetail(
    title: 'Мужская стрижка',
    imageUrl: 'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?q=80&w=1000&auto=format&fit=crop',
    duration: '45-60 мин',
    price: '30 BYN',
    description: 'Классическая техника стрижки... (ваш текст)',
  );

  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              ServiceImageHeaderSection(imageUrl: service.imageUrl),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ServiceInfoSection(
                      title: service.title,
                      duration: service.duration,
                      price: service.price,
                    ),
                    const SizedBox(height: 24),
                    ServiceDescriptionSection(description: service.description),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Кнопки управления (Назад и Бронировать) лучше тоже вынести в отдельные виджеты
        // или оставить в Stack, если они специфичны только для этого экрана.
        _buildBackButton(context),
        _buildBookingButton(),
      ],
    );
  }

  // Приватные методы для мелких элементов управления
  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 40,
      left: 16,
      child: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.8),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Widget _buildBookingButton() {
    return Positioned(
      bottom: 20, left: 20, right: 20,
      child: ElevatedButton(
        onPressed: () => print('Booking...'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF093882),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text('Забронировать', style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }
}