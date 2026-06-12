abstract class NotificationsEvent {}
class LoadNotifications extends NotificationsEvent {
  final String clientPhone;
  LoadNotifications(this.clientPhone);
}
class MarkAsRead extends NotificationsEvent {
  final int id;
  MarkAsRead(this.id);
}
