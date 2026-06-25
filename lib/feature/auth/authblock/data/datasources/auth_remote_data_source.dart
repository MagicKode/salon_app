import 'package:dio/dio.dart';
import 'package:salon_flutter/feature/auth/authblock/data/models/register_request_model.dart';

import '../models/auth_request_model.dart';
import '../models/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> register(RegisterRequestModel request);
  Future<AuthResponseModel> login(AuthRequestModel request);
  Future<void> forgotPassword(String email);
  Future<void> resetPassword(String email, String code, String newPassword);
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

  @override
  Future<void> forgotPassword(String email) async{
    await dio.post('$baseUrl/forgot-password', data: {'email': email});
  }

  @override
  Future<void> resetPassword(String email, String code, String newPassword) async{
    await dio.post('$baseUrl/reset-password', data: {
      'email': email,
      'code': code,
      'newPassword': newPassword,
    });
  }
}
