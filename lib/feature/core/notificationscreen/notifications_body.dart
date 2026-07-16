import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/auth/authblock/bloc/auth_block.dart';
import 'package:salon_flutter/feature/auth/authblock/bloc/auth_state.dart';
import 'package:salon_flutter/feature/core/notificationscreen/sections/expandable_notification.dart';
import 'package:salon_flutter/uikit/widgets/errors/loading_widget.dart';
import 'package:salon_flutter/uikit/widgets/errors/network_error_widget.dart';

import 'bloc/notification_bloc.dart';
import 'bloc/notification_event.dart';
import 'bloc/notification_state.dart';

class NotificationsBody extends StatelessWidget {
  final bool isMaster;

  const NotificationsBody({super.key, required this.isMaster});

  String _getUserPhone(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      return authState.user.phoneNumber;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (context, state) {
        // ✅ Загрузка – красивый лоадер
        if (state is NotificationsLoading) {
          return const LoadingWidget(message: 'Загрузка уведомлений...');
        }

        // ✅ Ошибка с проверкой интернета
        if (state is NotificationsError) {
          return FutureBuilder<ConnectivityResult>(
            future: Connectivity().checkConnectivity(),
            builder: (context, snapshot) {
              final hasInternet = snapshot.data != ConnectivityResult.none;
              if (!hasInternet) {
                return NetworkErrorWidget(
                  message: 'Проверьте подключение к интернету',
                  onRetry: () {
                    final phone = _getUserPhone(context);
                    context.read<NotificationsBloc>().add(
                      LoadNotifications(phone),
                    );
                  },
                );
              }
              // Интернет есть, но ошибка
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              );
            },
          );
        }

        // ✅ Успешно загружены уведомления
        if (state is NotificationsLoaded) {
          if (state.notifications.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_off_rounded,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Нет уведомлений',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Здесь будут появляться ваши уведомления',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            );
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
                  context.read<NotificationsBloc>().add(
                    DeleteNotification(notification.id),
                  );
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 30,
                  ),
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
