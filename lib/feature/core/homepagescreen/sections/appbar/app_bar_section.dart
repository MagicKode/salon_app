import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/notificationscreen/notifications_screen.dart';

import '../../../../../config/theme/custom_colors.dart';
import '../../../../../uikit/strings/app_strings.dart';
import '../../../../../uikit/widgets/button/notifications_button.dart';
import '../../../../auth/authblock/bloc/auth_block.dart';
import '../../../../auth/authblock/bloc/auth_state.dart';
import '../../../notificationscreen/repository/notification_repository.dart';

class AppBarSection extends StatefulWidget  implements PreferredSizeWidget {
  final bool isMaster;

  const AppBarSection({super.key, required this.isMaster});

  @override
  State<AppBarSection> createState() => _AppBarSectionState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _AppBarSectionState extends State<AppBarSection> {
  int _unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _loadUnreadCount();
  }

  void _loadUnreadCount() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      context.read<NotificationRepository>().getUnreadCount(authState.user.phoneNumber)
          .then((count) {
        if (mounted) setState(() => _unreadCount = count);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
      final String userName = state is AuthSuccess
                ? state.user.name
                : (AppStrings.homeGuest ?? "Гость");

        return AppBar(
          backgroundColor: colors.backgroundPrimary,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${AppStrings.homeWelcome}$userName",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      Text(
                        AppStrings.homeSubtitle,
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  NotificationsButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  NotificationsScreen(isMaster: widget.isMaster),
                        ),
                      ).then((_) => _loadUnreadCount());
                    },
                    unreadCount: _unreadCount,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
