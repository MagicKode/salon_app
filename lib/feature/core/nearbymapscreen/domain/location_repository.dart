import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'interface/i_location-repository.dart';

class LocationRepository implements ILocationRepository {
  @override
  Future<LatLng> getCurrentLocation() async {
    // Используем среднюю точность для скорости
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
    );
    return LatLng(position.latitude, position.longitude);
  }

  @override
  double calculateDistance(LatLng from, LatLng to) {
    return Geolocator.distanceBetween(
          from.latitude,
          from.longitude,
          to.latitude,
          to.longitude,
        ) /
        1000;
  }
}
