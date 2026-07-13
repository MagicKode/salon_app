import 'package:shared_preferences/shared_preferences.dart';

class HiddenHistoryService {
  static const String _key = 'hidden_history_ids';

  Future<List<int>> getHiddenIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_key) ?? [];
      return list.map((e) => int.parse(e)).toList();
    } catch (e) {
      // Если плагин не готов, возвращаем пустой список – приложение не падает
      return [];
    }
  }

  Future<void> hideBooking(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ids = await getHiddenIds();
      if (!ids.contains(id)) {
        ids.add(id);
        await prefs.setStringList(_key, ids.map((e) => e.toString()).toList());
      }
    } catch (e) {
      // Игнорируем ошибки сохранения – можно добавить логирование
    }
  }

  Future<void> unhideBooking(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ids = await getHiddenIds();
      if (ids.contains(id)) {
        ids.remove(id);
        await prefs.setStringList(_key, ids.map((e) => e.toString()).toList());
      }
    } catch (e) {
      // Игнорируем
    }
  }

  Future<bool> isHidden(int id) async {
    final ids = await getHiddenIds();
    return ids.contains(id);
  }
}
