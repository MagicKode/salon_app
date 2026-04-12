import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:salon_flutter/feature/nearbymapscreen/sections/nearby_map_section.dart';

class NearbyMapBody extends StatefulWidget {
  @override
  _NearbyMapPageBodyState createState() => _NearbyMapPageBodyState();
}

class _NearbyMapPageBodyState extends State<NearbyMapBody> {
  // Переменные для управления состоянием
  final LatLng _barberShopCoords = const LatLng(53.894034, 27.541170);
  final String _distance = "1.2 км"; // Позже можно вычислять динамически
  final String _address = "ул. Мясникова 78";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Убираем AppBar или делаем его прозрачным, чтобы карта была на весь экран
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: CircleAvatar(
      //       backgroundColor: Colors.white,
      //       child: IconButton(
      //         icon: const Icon(Icons.arrow_back, color: Colors.black),
      //         onPressed: () => Navigator.pop(context),
      //       ),
      //     ),
      //   ),
      // ),

      // BottomNavBar остается на месте, Scaffold сам прижмет карту к нему
      body: Stack(
        children: [
          // 1. КАРТА НА ВЕСЬ ЭКРАН
          FlutterMap(
            options: MapOptions(
              initialCenter: _barberShopCoords,
              initialZoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.salon_flutter',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _barberShopCoords,
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_on,
                      color: Color(0xFF093882),
                      size: 45,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // 2. ИНФОРМАЦИОННАЯ КАРТОЧКА (Плавающая внизу)
          Positioned(
            left: 16,
            right: 16,
            bottom: 20, // Отступ от нижнего BottomBar
            child: _buildFloatingInfoCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0x9D093882), // Ваш цвет с прозрачностью
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Чтобы карточка не была на весь экран
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.directions_walk, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "До нас $_distance",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _address,
                      style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13),
                    ),
                  ],
                ),
              ),
              // Кнопка действия прямо в карточке
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.near_me, color: Colors.white, size: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }
}