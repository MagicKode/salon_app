import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/notificationscreen/repository/notification_repository.dart';

import '../../../uikit/colors/app_colors.dart';
import '../../../uikit/strings/app_strings.dart';
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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final phone = authState is AuthSuccess ? authState.user.phoneNumber : '';

        return BlocProvider(
          create: (_) => NotificationsBloc(context.read<NotificationRepository>())
            ..add(LoadNotifications(phone)),
          child: Scaffold(
            backgroundColor: AppColors.primaryWhite,
            appBar: AppBar(
              title: const Text(AppStrings.notifications,
                  style: TextStyle(color: AppColors.primaryBlack, fontWeight: FontWeight.bold)),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryBlack, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
              backgroundColor: AppColors.primaryWhite,
              elevation: 0,
              centerTitle: true,
            ),
            body: const NotificationsBody(),
            floatingActionButton: isMaster
                ? FloatingActionButton(
              backgroundColor: AppColors.primaryBlue,
              onPressed: () {}, // Создание уведомления мастером
              child: const Icon(Icons.add_alert, color: AppColors.primaryWhite),
            )
                : null,
          ),
        );
      },
    );
  }
}
