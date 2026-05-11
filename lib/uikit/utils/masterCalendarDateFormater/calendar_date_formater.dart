import 'package:intl/intl.dart';

class CalendarDateFormater {
  // логика для даты скрина Ваше расписание
  static String formatFullDate(DateTime date) {
    final String formatted = DateFormat('EEEE, d MMMM', 'ru').format(date);
    return formatted.isNotEmpty
        ? formatted[0].toUpperCase() + formatted.substring(1)
        : formatted;
  }
}