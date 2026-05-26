import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  Future<AuthUser> register({required String phoneNumber, required String password}) async {
    final requestModel = AuthRequestModel(phoneNumber: phoneNumber, password: password);

    // 1. Делаем сетевой запрос через DataSource
    final response = await remoteDataSource.register(requestModel);

    // 2. Сохраняем токен в безопасное хранилище устройства
    await secureStorage.write(key: 'jwt_token', value: response.token);
    await secureStorage.write(key: 'user_role', value: response.role);

    // 3. Возвращаем чистую сущность в доменный слой
    return AuthUser(token: response.token, role: response.role);
  }

  @override
  Future<AuthUser> login({required String phoneNumber, required String password}) async {
    final requestModel = AuthRequestModel(phoneNumber: phoneNumber, password: password);

    // 1. Делаем сетевой запрос
    final response = await remoteDataSource.login(requestModel);

    // 2. Сохраняем токен
    await secureStorage.write(key: 'jwt_token', value: response.token);
    await secureStorage.write(key: 'user_role', value: response.role);

    // 3. Возвращаем чистую сущность
    return AuthUser(token: response.token, role: response.role);
  }
}
