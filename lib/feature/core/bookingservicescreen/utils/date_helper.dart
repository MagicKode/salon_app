import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static List<DateTime> generateDays(int count) {
    final today = DateTime.now();
    return List.generate(
      count,
          (index) => DateTime(today.year, today.month, today.day + index),
    );
  }

  static String toMonthYear(DateTime date) {
    final String formatted = DateFormat('MMMM, yyyy', 'ru').format(date);
    return formatted[0].toUpperCase() + formatted.substring(1);
  }

  static String toWeekday(DateTime date) {
    return DateFormat('E', 'ru').format(date).toUpperCase();
  }

  static List<TimeOfDay> generateTimeSlots({
    required int startHour,
    required int endHour,
    required int intervalMinutes,
  }) {
    List<TimeOfDay> slots = [];
    var currentTime = TimeOfDay(hour: startHour, minute: 0);

    while (currentTime.hour < endHour) {
      slots.add(currentTime);

      int totalMinutes = currentTime.hour * 60 + currentTime.minute + intervalMinutes;
      currentTime = TimeOfDay(hour: totalMinutes ~/ 60, minute: totalMinutes % 60);
    }
    return slots;
  }

  static String formatTime(BuildContext context, TimeOfDay time) {
    return time.format(context);
  }
}
