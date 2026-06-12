import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/notification_bloc.dart';
import 'bloc/notification_event.dart';
import 'bloc/notification_state.dart';
import 'sections/notification_tile.dart';

class NotificationsBody extends StatelessWidget {
  const NotificationsBody({super.key});

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
              final n = state.notifications[index];
              return GestureDetector(
                onTap: () {
                  if (!n.isRead) {
                    context.read<NotificationsBloc>().add(MarkAsRead(n.id));
                  }
                },
                child: NotificationTile(notification: n),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
