import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:salon_flutter/feature/auth/fakeauth/data/models/register_request_model.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_request_model.dart';

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

    // 2. Сохраняем токен в безопасное хранилище устройства
    await secureStorage.write(key: 'jwt_token', value: response.token);
    await secureStorage.write(key: 'user_role', value: response.role);
    await secureStorage.write(key: 'user_name', value: response.firstName);
    await secureStorage.write(key: 'user_phone', value: response.phoneNumber);
    await secureStorage.write(key: 'user_email', value: response.email);

    // 3. Возвращаем чистую сущность в доменный слой
    return AuthUser(
      token: response.token,
      role: response.role,
      name: response.firstName,
      phoneNumber: response.phoneNumber,
      email: response.email,
    );
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

    // 1. Делаем сетевой запрос
    final response = await remoteDataSource.login(requestModel);

    // 2. Сохраняем токен
    await secureStorage.write(key: 'jwt_token', value: response.token);
    await secureStorage.write(key: 'user_role', value: response.role);
    await secureStorage.write(key: 'user_name', value: response.firstName);
    await secureStorage.write(key: 'user_phone', value: response.phoneNumber);
    await secureStorage.write(key: 'user_email', value: response.email);

    // 3. Возвращаем чистую сущность
    return AuthUser(
      token: response.token,
      role: response.role,
      name: response.firstName,
      phoneNumber: response.phoneNumber,
      email: response.email,
    );
  }
}
