
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/notification_repository.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationRepository _repository;

  NotificationsBloc(this._repository) : super(NotificationsLoading()) {
    on<LoadNotifications>((event, emit) async {
      try {
        final list = await _repository.getNotifications(event.clientPhone);
        emit(NotificationsLoaded(list));
      } catch (e) {
        emit(NotificationsError(e.toString()));
      }
    });

    on<MarkAsRead>((event, emit) async {
      await _repository.markAsRead(event.id);
    });
  }
}
