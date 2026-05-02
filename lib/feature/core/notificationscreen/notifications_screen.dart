import 'package:flutter/material.dart';
import '../../../../uikit/colors/app_colors.dart';
import '../../../../uikit/strings/app_strings.dart';
import 'notifications_body.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        title: const Text(
          AppStrings.notifications,
          style: TextStyle(color: AppColors.primaryBlack, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryBlack, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        centerTitle: true,
      ),
      body: const NotificationsBody(),
    );
  }
}
