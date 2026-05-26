import '../entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> register({required String phoneNumber, required String password});
  Future<AuthUser> login({required String phoneNumber, required String password});
}
