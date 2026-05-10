import '../../../../uikit/assets/app_assets.dart';
import '../domain/mock_user.dart';

class AuthService {
  // Список "базы данных"
  static final List<MockUser> _users = [
    MockUser(
      name: "Павел",
      email: "pavel.yaroshenko@example.com",
      phone: "+375291234567",
      // Вводи этот номер для входа под мастером
      password: "777",
      role: "master",
      avatarUrl: AppAssets.pavelImg, // Путь к фото Павла
    ),
  ];

  // Текущий вошедший пользователь
  static MockUser? currentUser;

  static bool login(String phone, String password) {
    // Очищаем вводимый телефон от лишних символов (пробелы, скобки),
    // чтобы сравнение было точным, если Павел введет маской
    final cleanPhone = phone.replaceAll(RegExp(r'\D'), '');

    final user = _users.cast<MockUser?>().firstWhere((u) {
      final storedPhone = u?.phone.replaceAll(RegExp(r'\D'), '') ?? '';
      return storedPhone == cleanPhone && u?.password == password;
    }, orElse: () => null);

    if (user != null) {
      currentUser = user;
      return true;
    }
    return false;
  }

  static void register(MockUser user) {
    _users.add(user);
    currentUser = user;
  }
}
