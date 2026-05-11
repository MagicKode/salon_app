import 'package:intl/intl.dart';

class AppDateFormats {
  static String formatBookingDate(DateTime dateTime) {
    return DateFormat('MMMM d, y — HH:mm', 'ru').format(dateTime);
  }
}
