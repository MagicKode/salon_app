import 'package:latlong2/latlong.dart';
import 'package:salon_flutter/feature/core/nearbymapscreen/domain/location_model.dart';

enum NearbyStatus { initial, loading, loaded, error }

class NearbyState {
  final NearbyStatus status;

  // Салон — обязательное поле, так как он известен сразу
  final LocationModel shopLocation;

  // Координаты пользователя подтянутся позже
  final LatLng? userLocation;
  final String? errorMessage;

  const NearbyState({
    required this.shopLocation,
    this.status = NearbyStatus.initial,
    this.userLocation,
    this.errorMessage,
  });

  bool get isLoading => status == NearbyStatus.loading;
  bool get hasError => status == NearbyStatus.error;
  bool get isLoaded => status == NearbyStatus.loaded;

  NearbyState copyWith({
    NearbyStatus? status,
    LocationModel? shopLocation,
    LatLng? userLocation,
    String? errorMessage,
  }) {
    return NearbyState(
      status: status ?? this.status,
      shopLocation: shopLocation ?? this.shopLocation,
      userLocation: userLocation ?? this.userLocation,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
