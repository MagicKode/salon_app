import 'package:flutter/material.dart';
import '../../../../uikit/colors/app_colors.dart';
import '../../../../uikit/strings/app_strings.dart';
import '../domain/bottom_nav_item.dart';
import '../domain/nav_item_model.dart';

class BottomNavBarSection extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBarSection({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  // Список можно вынести даже в отдельный конфиг-файл
  static const List<NavItemModel> _navItems = [
    NavItemModel(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: AppStrings.navHome,
    ),
    NavItemModel(
      icon: Icons.add_task,
      activeIcon: Icons.add_task,
      label: AppStrings.navBooking,
    ),
    NavItemModel(
      icon: Icons.menu_book_outlined,
      activeIcon: Icons.menu_book,
      label: AppStrings.navHistory,
    ),
    NavItemModel(
      icon: Icons.person_outlined,
      activeIcon: Icons.person,
      label: AppStrings.navProfile,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
          children: List.generate(_navItems.length, (index) {
            final item = _navItems[index];
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
