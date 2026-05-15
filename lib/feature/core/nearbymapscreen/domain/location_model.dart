import 'package:latlong2/latlong.dart';

class LocationModel {
  final LatLng coordinates;
  final String address;
  final double? distanceInKm;
  final double? heading;

  const LocationModel({
    required this.coordinates,
    required this.address,
    this.distanceInKm,
    this.heading,
  });

  // copyWith необходим для Cubit, чтобы обновлять только дистанцию
  // или только направление (heading)
  LocationModel copyWith({
    LatLng? coordinates,
    String? address,
    double? distanceInKm,
    double? heading,
  }) {
    return LocationModel(
      coordinates: coordinates ?? this.coordinates,
      address: address ?? this.address,
      distanceInKm: distanceInKm ?? this.distanceInKm,
      heading: heading ?? this.heading,
    );
  }

  String get formattedDistance => distanceInKm != null
      ? '${distanceInKm!.toStringAsFixed(1)} км'
      : '... км';

  // Полезно добавить для отладки
  @override
  String toString() => 'LocationModel(address: $address, distance: $distanceInKm)';
}
