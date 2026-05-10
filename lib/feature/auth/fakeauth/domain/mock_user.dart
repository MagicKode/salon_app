class MockUser {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String role; // 'client' или 'master'
  final String? avatarUrl;

  MockUser({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.role = 'client',
    this.avatarUrl,
  });
}
