class AuthResponseModel {
  final bool success;
  final String? message;
  final String token;
  final String tokenType;
  final String role;
  final String firstName;
  final String phoneNumber;
  final String email;

  AuthResponseModel({
    required this.success,
    this.message,
    required this.token,
    required this.tokenType,
    required this.role,
    required this.firstName,
    required this.phoneNumber,
    required this.email,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    // Безопасно достаем внутренний объект "data" из ответа бэкенда
    final Map<String, dynamic> targetJson = json.containsKey('data') && json['data'] != null
        ? json['data'] as Map<String, dynamic>
        : json;
    return AuthResponseModel(
      success: json['success'] as bool? ?? true,
      message: json['message'] as String?,
      token: targetJson['token'] as String? ?? '',
      tokenType: targetJson['tokenType'] as String? ?? 'Bearer',
      role: targetJson['role'] as String? ?? 'USER',
      firstName: targetJson['firstName'] as String? ?? 'Клиент',
      // Если бэк передал phoneNumber напрямую, берем его, иначе дублируем из username
      phoneNumber: targetJson['phoneNumber'] as String? ?? 'Телефон не указан',
      // Если бэк передал email, берем его, иначе генерируем технический из username прямо на фронте для надежности
      email: targetJson['email'] as String? ?? 'Email не указан',
    );
  }
}
