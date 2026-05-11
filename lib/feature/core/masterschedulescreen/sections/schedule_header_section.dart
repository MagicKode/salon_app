import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../master_schedule_screen.dart';

class ScheduleHeaderSection extends StatelessWidget implements PreferredSizeWidget {
  final DateTime focusedDay;
  final CalendarViewMode viewMode;
  final Function(CalendarViewMode) onViewModeChanged;

  const ScheduleHeaderSection({
    super.key,
    required this.focusedDay,
    required this.viewMode,
    required this.onViewModeChanged,
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
      actions: [
        // Тот самый значок фильтра из твоего запроса
        PopupMenuButton<CalendarViewMode>(
          icon: const Icon(Icons.filter_list, color: AppColors.primaryBlue),
          onSelected: onViewModeChanged,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          itemBuilder: (context) => [
            _buildMenuItem(CalendarViewMode.week, AppStrings.weeklyOrders, Icons.view_week_outlined),
            _buildMenuItem(CalendarViewMode.month, AppStrings.monthlyOrders, Icons.calendar_month_outlined),
          ],
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  PopupMenuItem<CalendarViewMode> _buildMenuItem(CalendarViewMode mode, String text, IconData icon) {
    return PopupMenuItem(
      value: mode,
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primaryBlue),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
