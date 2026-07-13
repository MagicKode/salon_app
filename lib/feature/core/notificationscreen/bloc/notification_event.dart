abstract class NotificationsEvent {}
class LoadNotifications extends NotificationsEvent {
  final String clientPhone;
  LoadNotifications(this.clientPhone);
}
class MarkAsRead extends NotificationsEvent {
  final int id;
  MarkAsRead(this.id);
}

class DeleteNotification extends NotificationsEvent {
  final int notificationId;
  DeleteNotification(this.notificationId);
  @override
  List<Object?> get props => [notificationId];
}
