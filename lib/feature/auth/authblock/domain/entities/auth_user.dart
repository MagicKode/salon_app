class AuthUser {
  final String token;
  final String role;
  final String name;
  final String phoneNumber;
  final String email;

  AuthUser({
    required this.token,
    required this.role,
    required this.name,
    required this.phoneNumber,
    required this.email,
  });
}
