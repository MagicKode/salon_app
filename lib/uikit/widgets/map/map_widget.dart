import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../feature/core/nearbymapscreen/domain/location_model.dart';
import '../../colors/app_colors.dart';

class MapWidget extends StatelessWidget {
  final LocationModel shopLocation;
  final LocationModel? userLocation;
  final List<LatLng> routePoints;

  const MapWidget({
    super.key,
    required this.shopLocation,
    this.userLocation,
    this.routePoints = const [],
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: shopLocation.coordinates,
        initialZoom: 15.5,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.salon_flutter',
          retinaMode: true,
        ),

        // Маршрут
        if (routePoints.isNotEmpty)
          PolylineLayer(
            polylines: [
              Polyline(
                points: routePoints,
                color: AppColors.primaryBlue.withOpacity(0.85),
                strokeWidth: 5.5,
                borderStrokeWidth: 2.5,
                borderColor: Colors.white,
              ),
            ],
          ),

        MarkerLayer(
          markers: [
            // Маркер магазина
            Marker(
              point: shopLocation.coordinates,
              width: 70,
              height: 70,
              child: const Icon(
                Icons.location_on,
                color: AppColors.lightBlue,
                size: 55,
              ),
            ),

            // Маркер пользователя (Радар со стрелкой)
            if (userLocation != null)
              Marker(
                point: userLocation!.coordinates,
                width: 60,
                height: 60,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Внешний полупрозрачный круг (эффект пульсации/радара)
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.withOpacity(0.2),
                      ),
                    ),

                    // Вращающаяся стрелка направления
                    AnimatedRotation(
                      // turns: 1.0 = 360 градусов.
                      // Делим heading на 360, чтобы получить долю оборота.
                      turns: (userLocation!.heading ?? 0) / 360,
                      duration: const Duration(milliseconds: 250),
                      child: const Icon(
                        Icons.navigation, // Стрелка-указатель
                        color: AppColors.primaryBlue,
                        size: 30,
                      ),
                    ),

                    // Центральная точка (белая обводка делает её заметнее)
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryBlue,
                        border: Border.all(color: AppColors.primaryWhite, width: 2),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
