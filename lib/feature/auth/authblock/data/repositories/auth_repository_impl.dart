import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:salon_flutter/feature/auth/authblock/data/models/register_request_model.dart';
import 'package:salon_flutter/uikit/constatns/storage_keys.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_request_model.dart';
import '../models/auth_response_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final FlutterSecureStorage secureStorage;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.secureStorage,
  });

  @override
  Future<AuthUser> register({
    required String phoneNumber,
    required String password,
    required String firstName,
    required String email,
  }) async {
    final requestModel = RegisterRequestModel(
      phoneNumber: phoneNumber,
      password: password,
      firstName: firstName,
      email: email,
    );

    // 1. Делаем сетевой запрос через DataSource
    final response = await remoteDataSource.register(requestModel);
    await _saveUserData(response);
    return _toAuthUser(response);
  }

  @override
  Future<AuthUser> login({
    required String phoneNumber,
    required String password,
  }) async {
    final requestModel = AuthRequestModel(
      phoneNumber: phoneNumber,
      password: password,
    );
    final response = await remoteDataSource.login(requestModel);
    await _saveUserData(response);
    return _toAuthUser(response);
  }

  @override
  Future<void> logout() async {
    await secureStorage.deleteAll();
  }

  @override
  Future<AuthUser?> getAuthenticatedUser() async {
    // ✅ исправлено: используем _tokenKey
    final token = await secureStorage.read(key: StorageKeys.token_key);
    if (token == null || token.isEmpty) return null;

    final role = await secureStorage.read(key: StorageKeys.role_key) ?? '';
    final name = await secureStorage.read(key: StorageKeys.name_key) ?? '';
    final phone = await secureStorage.read(key: StorageKeys.phone_key) ?? '';
    final email = await secureStorage.read(key: StorageKeys.email_key) ?? '';

    return AuthUser(
      token: token,
      role: role,
      name: name,
      phoneNumber: phone,
      email: email,
    );
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: StorageKeys.token_key);
  }

  @override
  Future<String?> getUserPhone() async {
    return await secureStorage.read(key: StorageKeys.phone_key);
  }

  Future<void> _saveUserData(AuthResponseModel response) async {
    await secureStorage.write(key: StorageKeys.token_key, value: response.token);
    await secureStorage.write(key: StorageKeys.role_key, value: response.role);
    await secureStorage.write(key: StorageKeys.name_key, value: response.firstName);
    await secureStorage.write(key: StorageKeys.phone_key, value: response.phoneNumber);
    await secureStorage.write(key: StorageKeys.email_key, value: response.email);
  }

  AuthUser _toAuthUser(AuthResponseModel response) {
    return AuthUser(
      token: response.token,
      role: response.role,
      name: response.firstName,
      phoneNumber: response.phoneNumber,
      email: response.email,
    );
  }

  @override
  Future<void> forgotPassword(String email) async{
    await remoteDataSource.forgotPassword(email);
  }

  @override
  Future<void> resetPassword(String email, String code, String newPassword) async {
    await remoteDataSource.resetPassword(email, code, newPassword);
  }
}
