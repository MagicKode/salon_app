import '../domain/notification_model.dart';

abstract class NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationModel> notifications;

  NotificationsLoaded(this.notifications);

  NotificationsLoaded copyWith({List<NotificationModel>? notifications}) {
    return NotificationsLoaded(notifications ?? this.notifications);
  }
}

class NotificationsError extends NotificationsState {
  final String message;

  NotificationsError(this.message);
}
