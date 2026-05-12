import 'package:flutter/material.dart';
import '../../../../uikit/colors/app_colors.dart';
import '../../../../uikit/strings/app_strings.dart';
import '../../../uikit/widgets/card/create_notification_bottom_card.dart';
import 'notifications_body.dart';

class NotificationsScreen extends StatelessWidget {
  final bool isMaster;

  const NotificationsScreen({super.key, required this.isMaster});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        title: const Text(
          AppStrings.notifications,
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryBlack,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        centerTitle: true,
      ),
      body: const NotificationsBody(),

      // Кнопка создания видна ТОЛЬКО Мастеру
      floatingActionButton:
          isMaster
              ? FloatingActionButton(
                backgroundColor: AppColors.primaryBlue,
                onPressed: () => _showCreateNotificationSheet(context),
                child: const Icon(Icons.add_alert, color: AppColors.primaryWhite),
              )
              : null,
    );
  }

  void _showCreateNotificationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CreateNotificationBottomSheet(),
    );
  }
}
