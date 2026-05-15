import 'package:latlong2/latlong.dart';

abstract class ILocationRepository {
  /// Получает текущие координаты пользователя.
  /// Мы возвращаем [LatLng], так как это универсальный стандарт для карт.
  Future<LatLng> getCurrentLocation();

  /// Вычисляет расстояние между двумя точками в километрах.
  /// Вынесено в интерфейс, чтобы можно было легко подменить
  /// реализацию (например, на более точную через API).
  double calculateDistance(LatLng from, LatLng to);
}
