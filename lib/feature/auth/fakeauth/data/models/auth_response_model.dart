class AuthResponseModel {
  final bool success;
  final String? message;
  final String token;
  final String tokenType;
  final String role;

  AuthResponseModel({
    required this.success,
    this.message,
    required this.token,
    required this.tokenType,
    required this.role,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    // Безопасно достаем внутренний объект "data" из ответа бэкенда
    final data = json['data'] as Map<String, dynamic>;
    return AuthResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String?,
      token: data['token'] as String,
      tokenType: data['tokenType'] as String,
      role: data['role'] as String,
    );
  }
}
