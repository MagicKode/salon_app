class SalonEntity {
  final int id;
  final String name;
  final String address;
  final String description;
  final double latitude;
  final double longitude;
  final String phoneNumber;
  final double rating;
  final String workingHours;

  const SalonEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber,
    required this.rating,
    required this.workingHours,
  });
}

// Model (Слой данных, отвечающий за маппинг из JSON)
class SalonModel extends SalonEntity {
  const SalonModel({
    required super.id,
    required super.name,
    required super.address,
    required super.description,
    required super.latitude,
    required super.longitude,
    required super.phoneNumber,
    required super.rating,
    required super.workingHours,
  });

  // Фабричный метод для парсинга вложенного объекта "data" из твоего JSON-ответа
  factory SalonModel.fromJson(Map<String, dynamic> json) {
    return SalonModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      description: json['description'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      phoneNumber: json['phoneNumber'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      workingHours: json['workingHours'] as String? ?? '',
    );
  }
}
