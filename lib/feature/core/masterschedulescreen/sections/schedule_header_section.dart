import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../master_schedule_screen.dart';

class ScheduleHeaderSection extends StatelessWidget implements PreferredSizeWidget {
  final DateTime focusedDay;

  const ScheduleHeaderSection({
    super.key,
    required this.focusedDay,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryWhite,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        AppStrings.scheduler,
        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlack),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
