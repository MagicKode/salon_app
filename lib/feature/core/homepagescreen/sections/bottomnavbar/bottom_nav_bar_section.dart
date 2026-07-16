import 'package:flutter/material.dart';

import '../../../../../config/theme/custom_colors.dart';
import '../../../../../uikit/strings/app_strings.dart';
import '../../domain/bottom_nav_item.dart';
import '../../domain/nav_item_model.dart';

class BottomNavBarSection extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isMaster;
  final int unreadCount;

  const BottomNavBarSection({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.isMaster = false,
    this.unreadCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    // Формируем список айтемов динамически внутри build
    final List<NavItemModel> dynamicNavItems = [
      const NavItemModel(
        icon: Icons.home_outlined,
        activeIcon: Icons.home,
        label: AppStrings.navHome,
      ),
      // УСЛОВИЕ ДЛЯ ВТОРОЙ ВКЛАДКИ
      NavItemModel(
        icon: isMaster ? Icons.list_alt_outlined : Icons.add_task,
        activeIcon: isMaster ? Icons.list_alt_outlined : Icons.add_task,
        label: isMaster ? AppStrings.orders : AppStrings.navBooking,
      ),
      NavItemModel(
        icon:
            isMaster ? Icons.calendar_month_outlined : Icons.menu_book_outlined,
        activeIcon: isMaster ? Icons.calendar_month : Icons.menu_book,
        label: isMaster ? AppStrings.scheduler : AppStrings.navHistory,
      ),
      const NavItemModel(
        icon: Icons.person_outlined,
        activeIcon: Icons.person,
        label: AppStrings.navProfile,
      ),
    ];

    return SafeArea(
      top: false,
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: colors.backgroundPrimary,
          boxShadow: [
            BoxShadow(
              color: colors.shadow,
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(dynamicNavItems.length, (index) {
            final item = dynamicNavItems[index];
            return BottomNavItem(
              index: index,
              currentIndex: currentIndex,
              icon: item.icon,
              activeIcon: item.activeIcon,
              label: item.label,
              unreadCount: index == 2 ? unreadCount : 0,
              onTap: onTap,
            );
          }),
        ),
      ),
    );
  }
}
