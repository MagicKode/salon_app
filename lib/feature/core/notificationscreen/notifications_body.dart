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

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            itemCount: state.notifications.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return ExpandableNotification(
                notification: state.notifications[index],
                onRead: (id) {
                  context.read<NotificationsBloc>().add(MarkAsRead(id));
                },
                isMaster: isMaster,
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
