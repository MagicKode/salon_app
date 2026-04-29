import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class NearbyMapSection extends StatefulWidget {
  final LatLng shopLocation;

  const NearbyMapSection({super.key, required this.shopLocation});

  @override
  State<NearbyMapSection> createState() => _NearbyMapSectionState();
}

class _NearbyMapSectionState extends State<NearbyMapSection> {
  // Контроллер для программного перемещения карты
  final MapController _mapController = MapController();
  LatLng? _userLocation;

  // Метод для получения текущей геопозиции и перемещения камеры
  Future<void> _locateMe() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    final position = await Geolocator.getCurrentPosition();
    final userLatLng = LatLng(position.latitude, position.longitude);

    setState(() {
      _userLocation = userLatLng;
    });

    // Плавно перемещаем карту к пользователю
    _mapController.move(userLatLng, 15.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Убираем AppBar, чтобы карта была на весь экран
      body: Stack(
        children: [
          // 1. Полноэкранная карта
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: widget.shopLocation,
              initialZoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.salon_flutter',
              ),
              MarkerLayer(
                markers: [
                  // Маркер салона
                  Marker(
                    point: widget.shopLocation,
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_on,
                      color: Color(0xFF093882),
                      size: 45,
                    ),
                  ),
                  // Маркер пользователя (если найден)
                  if (_userLocation != null)
                    Marker(
                      point: _userLocation!,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                ],
              ),
            ],
          ),

          // 2. Кнопка "Найти меня" (плавающая справа)
          Positioned(
            right: 16,
            bottom: 120, // Чуть выше карточки
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              elevation: 4,
              onPressed: _locateMe,
              child: const Icon(Icons.gps_fixed, color: Color(0xFF093882)),
            ),
          ),

          // 3. Информационная карточка (ваша полупрозрачная)
          Positioned(left: 16, right: 16, bottom: 24, child: _buildInfoCard()),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0x9D093882), // Тот самый цвет
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.directions_walk, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Парикмахерская рядом",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "ул. Примерная, д. 1",
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {}, // Логика маршрута
            icon: const Icon(Icons.near_me, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
