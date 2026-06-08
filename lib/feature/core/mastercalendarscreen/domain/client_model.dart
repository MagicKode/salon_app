// lib/feature/core/mastercalendarscreen/domain/client_model.dart
class ClientModel {
  final String phoneNumber;
  final String firstName;
  final String? lastName;
  final String? email;

  const ClientModel({
    required this.phoneNumber,
    required this.firstName,
    this.lastName,
    this.email,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      phoneNumber: json['phoneNumber'] as String? ?? '',
      firstName: json['firstName'] as String? ?? 'Клиент',
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
    );
  }

  String get displayName {
    if (lastName != null && lastName!.isNotEmpty) {
      return '$firstName $lastName';
    }
    return firstName;
  }
}
