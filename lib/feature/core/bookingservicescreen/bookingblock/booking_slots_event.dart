abstract class BookingSlotsEvent {}

// Событие запроса слотов времени для конкретного мастера на выбранную дату
class LoadBookingSlotsEvent extends BookingSlotsEvent {
  final String masterName;
  final DateTime date;

  LoadBookingSlotsEvent({required this.masterName, required this.date});
}