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

  LocationModel copyWith({double? distanceInKm}) {
    return LocationModel(
      coordinates: coordinates,
      address: address,
      distanceInKm: distanceInKm ?? this.distanceInKm,
      heading: heading ?? this.heading,
    );
  }

  String get formattedDistance => distanceInKm != null
      ? '${distanceInKm!.toStringAsFixed(1)} км'
      : '... км';
}
