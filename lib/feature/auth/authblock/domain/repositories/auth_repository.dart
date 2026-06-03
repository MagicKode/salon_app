import '../entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> register({
    required String phoneNumber,
    required String password,
    required String firstName,
    required String email,
  });

  Future<AuthUser> login({
    required String phoneNumber,
    required String password,
  });

  Future<void> logout();

  Future<AuthUser?> getAuthenticatedUser();
}
