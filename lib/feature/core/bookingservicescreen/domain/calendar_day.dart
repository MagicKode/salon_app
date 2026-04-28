class CalendarDay {
  final String dayOfWeek;
  final String dayNumber;
  final bool isSelected;

  const CalendarDay({
    required this.dayOfWeek,
    required this.dayNumber,
    this.isSelected = false
  });
}
