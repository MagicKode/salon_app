import '../../../../config/master_name_mapping.dart';
import 'user_role.dart';

class AuthUser {
  final String token;
  final String role;
  final String name;
  final String phoneNumber;
  final String email;

  AuthUser({
    required this.token,
    required this.role,
    required this.name,
    required this.phoneNumber,
    required this.email,
  });

  // Добавляем геттер для типизированной роли
  UserRole get parsedRole => UserRole.fromString(role);

  bool get isMaster => parsedRole == UserRole.master;

  /// Имя мастера для API запросов (латиница)
  String get masterName => MasterNameMapping.getApiName(name);
}
