import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../domain/interface/i_location-repository.dart';
import '../domain/location_model.dart';
import 'nearby_state.dart';

class NearbyCubit extends Cubit<NearbyState> {
  final ILocationRepository repository;
  final LocationModel shopLocation;

  final _mapActionController = StreamController<LatLng>.broadcast();
  Stream<LatLng> get mapActionStream => _mapActionController.stream;

  NearbyCubit({
    required this.repository,
    required this.shopLocation,
  }) : super(NearbyState(shopLocation: shopLocation));

  Future<void> init() async {
    // Если мы уже загружаемся, не запускаем процесс повторно
    if (state.status == NearbyStatus.loading) return;

    // Сразу пытаемся получить позицию, но не блокируем UI статусом loading
    try {
      final userCoords = await repository.getCurrentLocation();

      final distance = repository.calculateDistance(
        userCoords,
        state.shopLocation.coordinates,
      );

      emit(
        state.copyWith(
          userLocation: userCoords,
          shopLocation: state.shopLocation.copyWith(distanceInKm: distance),
          status: NearbyStatus.loaded,
        ),
      );

      // 4. После загрузки автоматически центрируем карту на пользователе
      // moveToUser();

    } catch (e) {
      emit(state.copyWith(
        status: NearbyStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
  // Метод для кнопки "Моя локация"
  void moveToUser() {
    if (state.userLocation != null) {
      // Отправляем координаты в стрим, который теперь слушает MapWidget
      _mapActionController.add(state.userLocation!);
    } else {
      // Если локации нет — запускаем поиск заново
      init();
    }
  }

  @override
  Future<void> close() {
    _mapActionController.close(); // Обязательно закрываем стрим
    return super.close();
  }
}
