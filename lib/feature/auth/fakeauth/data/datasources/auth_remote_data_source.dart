import 'package:dio/dio.dart';
import 'package:salon_flutter/feature/auth/fakeauth/data/models/register_request_model.dart';

import '../models/auth_request_model.dart';
import '../models/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> register(RegisterRequestModel request);
  Future<AuthResponseModel> login(AuthRequestModel request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  final String baseUrl;

  AuthRemoteDataSourceImpl({
    required this.dio,
    required this.baseUrl, // Передаем значение из main.dart
  });

  @override
  Future<AuthResponseModel> register(RegisterRequestModel request) async {
    final response = await dio.post(
      '$baseUrl/register',
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<AuthResponseModel> login(AuthRequestModel request) async {
    final response = await dio.post(
      '$baseUrl/login',
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(response.data);
  }
}
