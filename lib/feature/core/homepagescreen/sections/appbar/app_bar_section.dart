import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/notificationscreen/notifications_screen.dart';

import '../../../../../uikit/colors/app_colors.dart';
import '../../../../../uikit/strings/app_strings.dart';
import '../../../../../uikit/widgets/button/notifications_button.dart';
import '../../../../auth/fakeauth/authservice/auth_service.dart';

class AppBarSection extends StatelessWidget implements PreferredSizeWidget {
  final bool isMaster;

  const AppBarSection({super.key, required this.isMaster});

  @override
  Widget build(BuildContext context) {
    // Получаем имя текущего пользователя или "Гость", если данных нет
    final userName = AuthService.currentUser?.name ?? AppStrings.homeGuest;

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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                          (context) => NotificationsScreen(isMaster: isMaster),
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
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
