enum UserRole {
  client,
  master;


  static UserRole fromString(String role) {
    final cleanRole = role.toLowerCase();

    if (cleanRole.contains('master')) {
      return UserRole.master;
    }

    return UserRole.client;
  }
}
