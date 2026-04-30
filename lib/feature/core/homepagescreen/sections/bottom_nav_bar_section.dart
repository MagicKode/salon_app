import 'package:flutter/material.dart';
// Убедись, что путь к AppColors верный
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class BottomNavBarSection extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBarSection({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<_NavItemData> _navItems = [
    _NavItemData(icon: Icons.home_outlined, activeIcon: Icons.home),
    _NavItemData(
      icon: Icons.calendar_today_outlined,
      activeIcon: Icons.calendar_today,
    ),
    _NavItemData(icon: Icons.person_outlined, activeIcon: Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    // Используем SafeArea, чтобы защитить нижнюю часть на iPhone/Android
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
            return _NavItem(
              index: index,
              currentIndex: currentIndex,
              icon: _navItems[index].icon,
              activeIcon: _navItems[index].activeIcon,
              onTap: onTap,
            );
          }),
        ),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final IconData activeIcon;

  const _NavItemData({required this.icon, required this.activeIcon});
}

class _NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final IconData activeIcon;
  final Function(int) onTap;

  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.activeIcon,
    required this.onTap,
  });

  bool get _isSelected => index == currentIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isSelected ? activeIcon : icon,
              color: _isSelected ? AppColors.primaryBlue : AppColors.primaryGrey,
              size: 26,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(top: 4),
              height: 4,
              width: _isSelected ? 4 : 0,
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
