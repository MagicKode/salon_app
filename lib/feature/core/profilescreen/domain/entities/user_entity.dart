class UserEntity {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String? avatarUrl; // null, если фото нет

  const UserEntity({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    this.avatarUrl,
  });

  // Геттер для полного имени
  String get fullName => '$firstName $lastName';
}
