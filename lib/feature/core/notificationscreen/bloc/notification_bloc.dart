import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/notification_repository.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationRepository _repository;
  String _clientPhone = '';

  NotificationsBloc(this._repository) : super(NotificationsLoading()) {
    on<LoadNotifications>((event, emit) async {
      _clientPhone = event.clientPhone;
      try {
        final list = await _repository.getNotifications(event.clientPhone);
        emit(NotificationsLoaded(list));
      } catch (e) {
        emit(NotificationsError(e.toString()));
      }
    });

    on<MarkAsRead>((event, emit) async {
      await _repository.markAsRead(event.id);
      try {
        final list = await _repository.getNotifications(_clientPhone);
        emit(NotificationsLoaded(list));
      } catch (e) {
        // Оставляем текущее состояние
      }
    });

    on<DeleteNotification>((event, emit) async {
      if (state is NotificationsLoaded) {
        final currentState = state as NotificationsLoaded;
        try {
          await _repository.deleteNotification(event.notificationId);
          final updatedList = currentState.notifications
              .where((n) => n.id != event.notificationId)
              .toList();
          emit(currentState.copyWith(notifications: updatedList));
        } catch (e) {
          // можно показать ошибку, но для простоты проигнорируем
        }
      }
    });
  }
}
