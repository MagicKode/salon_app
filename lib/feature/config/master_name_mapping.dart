// lib/config/master_name_mapping.dart

/// Конфигурация для маппинга имен мастеров
/// Используется для конвертации русских имен в латиницу
/// при отправке запросов к API
class MasterNameMapping {
  // Статический маппинг известных мастеров
  static const Map<String, String> _knownMasters = {
    'Павел': 'Pavel',
    'Дмитрий': 'Dmitry',
    'Анна': 'Anna',
    'Елена': 'Elena',
    'Сергей': 'Sergey',
    'Александр': 'Alexander',
    'Михаил': 'Mikhail',
  };

  /// Получить имя мастера для API
  /// Если имя есть в маппинге - вернет латинскую версию
  /// Если нет - выполнит транслитерацию
  static String getApiName(String? russianName) {
    if (russianName == null || russianName.isEmpty) {
      return 'unknown';
    }

    // Проверяем известных мастеров
    if (_knownMasters.containsKey(russianName)) {
      return _knownMasters[russianName]!;
    }

    // Для новых мастеров - автоматическая транслитерация
    return _transliterate(russianName);
  }

  /// Транслитерация кириллицы в латиницу
  static String _transliterate(String text) {
    const Map<String, String> translitMap = {
      'а': 'a', 'б': 'b', 'в': 'v', 'г': 'g',
      'д': 'd', 'е': 'e', 'ё': 'e', 'ж': 'zh',
      'з': 'z', 'и': 'i', 'й': 'y', 'к': 'k',
      'л': 'l', 'м': 'm', 'н': 'n', 'о': 'o',
      'п': 'p', 'р': 'r', 'с': 's', 'т': 't',
      'у': 'u', 'ф': 'f', 'х': 'h', 'ц': 'ts',
      'ч': 'ch', 'ш': 'sh', 'щ': 'sch', 'ъ': '',
      'ы': 'y', 'ь': '', 'э': 'e', 'ю': 'yu',
      'я': 'ya',
      'А': 'A', 'Б': 'B', 'В': 'V', 'Г': 'G',
      'Д': 'D', 'Е': 'E', 'Ё': 'E', 'Ж': 'Zh',
      'З': 'Z', 'И': 'I', 'Й': 'Y', 'К': 'K',
      'Л': 'L', 'М': 'M', 'Н': 'N', 'О': 'O',
      'П': 'P', 'Р': 'R', 'С': 'S', 'Т': 'T',
      'У': 'U', 'Ф': 'F', 'Х': 'H', 'Ц': 'Ts',
      'Ч': 'Ch', 'Ш': 'Sh', 'Щ': 'Sch', 'Ъ': '',
      'Ы': 'Y', 'Ь': '', 'Э': 'E', 'Ю': 'Yu',
      'Я': 'Ya',
    };

    return text.split('').map((char) {
      return translitMap[char] ?? char;
    }).join();
  }
}
