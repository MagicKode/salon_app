import 'package:flutter/material.dart';
import '../../../../../uikit/colors/app_colors.dart';
import '../../../../../uikit/strings/app_strings.dart';
import '../../domain/bottom_nav_item.dart';
import '../../domain/nav_item_model.dart';

class BottomNavBarSection extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isMaster;

  const BottomNavBarSection({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.isMaster = false,
  });

  // // Список можно вынести даже в отдельный конфиг-файл
  // static const List<NavItemModel> _navItems = [
  //   NavItemModel(
  //     icon: Icons.home_outlined,
  //     activeIcon: Icons.home,
  //     label: AppStrings.navHome,
  //   ),
  //   NavItemModel(
  //     icon: isMaster ? Icons.calendar_today_outlined : Icons.add_task,
  //     activeIcon: isMaster ? Icons.calendar_today : Icons.add_task,
  //     label: isMaster ? "Календарь" : AppStrings.navBooking,
  //   ),
  //   NavItemModel(
  //     icon: Icons.menu_book_outlined,
  //     activeIcon: Icons.menu_book,
  //     label: AppStrings.navHistory,
  //   ),
  //   NavItemModel(
  //     icon: Icons.person_outlined,
  //     activeIcon: Icons.person,
  //     label: AppStrings.navProfile,
  //   ),
  // ];

  @override
  @override
  Widget build(BuildContext context) {
    // Формируем список айтемов динамически внутри build
    final List<NavItemModel> dynamicNavItems = [
      const NavItemModel(
        icon: Icons.home_outlined,
        activeIcon: Icons.home,
        label: AppStrings.navHome,
      ),
      // УСЛОВИЕ ДЛЯ ВТОРОЙ ВКЛАДКИ
      NavItemModel(
        icon: isMaster ? Icons.calendar_today_outlined : Icons.add_task,
        activeIcon: isMaster ? Icons.calendar_today : Icons.add_task,
        label: isMaster ? "Календарь" : AppStrings.navBooking,
      ),
      const NavItemModel(
        icon: Icons.menu_book_outlined,
        activeIcon: Icons.menu_book,
        label: AppStrings.navHistory,
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
          color: AppColors.primaryWhite,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlackShadow,
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
              onTap: onTap,
            );
          }),
        ),
      ),
    );
  }
}
