import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/notificationscreen/notifications_screen.dart';

import '../../../../../uikit/colors/app_colors.dart';
import '../../../../../uikit/strings/app_strings.dart';
import '../../../../../uikit/widgets/button/notifications_button.dart';
import '../../../../auth/fakeauth/bloc/auth_block.dart';
import '../../../../auth/fakeauth/bloc/auth_state.dart';

class AppBarSection extends StatelessWidget implements PreferredSizeWidget {
  final bool isMaster;

  const AppBarSection({super.key, required this.isMaster});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // Если юзер успешно авторизован, выводим его имя.
        // Замени "Пользователь" на имя из твоей модели, если бэк его возвращает в AuthSuccess (например: state.user.name)
        final userName =
            state is AuthSuccess
                ? (AppStrings.homeGuest ?? "Гость")
                : "Пользователь";

        return AppBar(
          backgroundColor: AppColors.primaryWhite,
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
                        ),
                      ),
                      Text(
                        AppStrings.homeSubtitle,
                        style: TextStyle(
                          color: AppColors.primaryGrey,
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
                                  NotificationsScreen(isMaster: isMaster),
                        ),
                      );
                    },
                    hasUnread: true,
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
