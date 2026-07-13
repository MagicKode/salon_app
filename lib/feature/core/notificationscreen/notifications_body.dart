import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/notificationscreen/sections/expandable_notification.dart';

import 'bloc/notification_bloc.dart';
import 'bloc/notification_event.dart';
import 'bloc/notification_state.dart';

class NotificationsBody extends StatelessWidget {
  final bool isMaster;

  const NotificationsBody({
    super.key,
    required this.isMaster
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (context, state) {
        if (state is NotificationsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is NotificationsError) {
          return Center(child: Text(state.message));
        }

        if (state is NotificationsLoaded) {
          if (state.notifications.isEmpty) {
            return const Center(child: Text("Нет уведомлений"));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            itemCount: state.notifications.length,
            itemBuilder: (context, index) {
              final notification = state.notifications[index];
              return Dismissible(
                key: Key(notification.id.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  context.read<NotificationsBloc>().add(DeleteNotification(notification.id));
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.delete, color: Colors.white, size: 30),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ExpandableNotification(
                    notification: notification,
                    onRead: (id) {
                      context.read<NotificationsBloc>().add(MarkAsRead(id));
                    },
                    isMaster: isMaster,
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
