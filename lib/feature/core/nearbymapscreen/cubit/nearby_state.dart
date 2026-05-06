import 'package:latlong2/latlong.dart';
import 'package:salon_flutter/feature/core/nearbymapscreen/domain/location_model.dart';

enum NearbyStatus { initial, loading, loaded, error }

class NearbyState {
  final NearbyStatus status;
  final LocationModel? shopLocation;
  final LocationModel? userLocation;
  final List<LatLng> routePoints;
  final String? errorMessage;

  const NearbyState({
    this.status = NearbyStatus.initial,
    this.shopLocation,
    this.userLocation,
    this.routePoints = const [],
    this.errorMessage,
  });

  bool get isLoading => status == NearbyStatus.loading;
  bool get hasError => status == NearbyStatus.error;
  bool get hasUserLocation => userLocation != null;

  NearbyState copyWith({
    NearbyStatus? status,
    LocationModel? shopLocation,
    LocationModel? userLocation,
    List<LatLng>? routePoints,
    String? errorMessage,
  }) {
    return NearbyState(
      status: status ?? this.status,
      shopLocation: shopLocation ?? this.shopLocation,
      userLocation: userLocation ?? this.userLocation,
      routePoints: routePoints ?? this.routePoints,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
