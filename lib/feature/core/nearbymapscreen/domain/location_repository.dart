import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'location_model.dart';

abstract class ILocationRepository {
  Future<LocationModel> getCurrentLocation();

  Future<double> calculateDistance(LatLng from, LatLng to);

  Future<String> getAddressFromCoordinates(LatLng coordinates);
}

class LocationRepository implements ILocationRepository {
  @override
  Future<LocationModel> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Геолокация выключена. Включите в настройках.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Доступ к геолокации запрещён');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Доступ к геолокации permanently denied');
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LocationModel(
      coordinates: LatLng(position.latitude, position.longitude),
      address: "Ваше местоположение", // можно позже добавить geocoding
      distanceInKm: null,
    );
  }

  @override
  Future<double> calculateDistance(LatLng from, LatLng to) async {
    return Geolocator.distanceBetween(
          from.latitude,
          from.longitude,
          to.latitude,
          to.longitude,
        ) /
        1000; // в километрах
  }

  @override
  Future<String> getAddressFromCoordinates(LatLng coordinates) async {
    // Для обратного геокодинга можно использовать geocoding пакет позже
    return "Ваше текущее местоположение";
  }
}
