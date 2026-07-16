import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/notificationscreen/repository/notification_repository.dart';

import '../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов
import '../../../uikit/strings/app_strings.dart';
import '../../../uikit/widgets/dialog/broadcast_dialog.dart';
import '../../auth/authblock/bloc/auth_block.dart';
import '../../auth/authblock/bloc/auth_state.dart';
import 'bloc/notification_bloc.dart';
import 'bloc/notification_event.dart';
import 'notifications_body.dart';

class NotificationsScreen extends StatelessWidget {
  final bool isMaster;

  const NotificationsScreen({super.key, required this.isMaster});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final phone =
            authState is AuthSuccess ? authState.user.phoneNumber : '';

        return BlocProvider(
          create:
              (_) =>
                  NotificationsBloc(context.read<NotificationRepository>())
                    ..add(LoadNotifications(phone)),
          child: Scaffold(
            backgroundColor: colors.backgroundPrimary, // ✅ динамический фон
            appBar: AppBar(
              title: Text(
                AppStrings.notifications,
                style: TextStyle(
                  color: colors.textPrimary, // ✅ динамический цвет текста
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: colors.textPrimary, // ✅ динамический цвет иконки
                  size: 20,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              backgroundColor: colors.backgroundPrimary,
              // ✅ динамический фон AppBar
              elevation: 0,
              centerTitle: true,
            ),
            body: NotificationsBody(isMaster: isMaster),
            floatingActionButton:
                isMaster
                    ? FloatingActionButton(
                      backgroundColor:
                          colors.primaryBlue, // ✅ динамический синий
                      onPressed: () {
                        final authState = context.read<AuthBloc>().state;
                        if (authState is AuthSuccess) {
                          showDialog(
                            context: context,
                            builder:
                                (_) => BroadcastDialog(
                                  onSend:
                                      (title, body) => context
                                          .read<NotificationRepository>()
                                          .broadcastToAll(
                                            title,
                                            body,
                                            authState.user.phoneNumber,
                                          ),
                                ),
                          );
                        }
                      },
                      child: Icon(
                        Icons.add_alert,
                        color: colors.textOnPrimary, // ✅ динамический белый
                      ),
                    )
                    : null,
          ),
        );
      },
    );
  }
}
