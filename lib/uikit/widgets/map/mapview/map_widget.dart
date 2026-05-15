import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:salon_flutter/uikit/widgets/map/mapview/user_location_marker.dart';

import '../../../../feature/core/nearbymapscreen/cubit/nearby_cubit.dart';
import '../../../../feature/core/nearbymapscreen/cubit/nearby_state.dart';
import '../../../colors/app_colors.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  // Контроллер теперь живет в State и не умирает при перерисовках
  late final MapController _mapController;
  StreamSubscription? _mapSub;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    _mapSub = context.read<NearbyCubit>().mapActionStream.listen((coords) {
      _mapController.move(coords, 15.5);
    });
  }

  @override
  void dispose() {
    _mapSub?.cancel();
    _mapController.dispose(); // Обязательно освобождаем ресурсы
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shopCoord = context.read<NearbyCubit>().shopLocation.coordinates;

    return BlocBuilder<NearbyCubit, NearbyState>(
      buildWhen: (p, c) => p.userLocation != c.userLocation,
      builder: (context, state) {
        return FlutterMap(
          mapController: _mapController, // ПРИВЯЗЫВАЕМ контроллер
          options: MapOptions(
            initialCenter: shopCoord,
            initialZoom: 15.5,
            // Позволяет кнопкам перехватывать нажатия, если они поверх
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.salon_flutter',
            ),
            MarkerLayer(
              markers: [
                // 1. Маркер салона
                Marker(
                  point: shopCoord,
                  width: 70,
                  height: 70,
                  child: const Icon(
                    Icons.location_on,
                    color: AppColors.lightBlue,
                    size: 55,
                  ),
                ),

                // 2. Маркер пользователя
                if (state.userLocation != null)
                  Marker(
                    point: state.userLocation!,
                    width: 60,
                    height: 60,
                    child: UserLocationMarker(
                      heading: state.shopLocation.heading ?? 0,
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
