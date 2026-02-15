import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class BottomNavBarSection extends StatelessWidget {
  final int initialIndex;
  final Function(int) onTabSelected;

  const BottomNavBarSection({
    Key? key,
    required this.initialIndex,
    required this.onTabSelected,
  }) : super(key: key);

  // Navigation items data
  static const List<_NavItemData> _navItems = [
    _NavItemData(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
    ),
    _NavItemData(
      icon: Icons.explore_outlined,
      activeIcon: Icons.explore,
    ),
    _NavItemData(
      icon: Icons.calendar_today_outlined,
      activeIcon: Icons.calendar_today,
    ),
    _NavItemData(
      icon: Icons.chat_bubble_outline,
      activeIcon: Icons.chat_bubble,
    ),
    _NavItemData(
      icon: Icons.person_outlined,
      activeIcon: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: _buildDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_navItems.length, (index) {
          return _NavItem(
            index: index,
            currentIndex: initialIndex,
            icon: _navItems[index].icon,
            activeIcon: _navItems[index].activeIcon,
            onTap: onTabSelected,
          );
        }),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border(
        top: BorderSide(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, -2),
        ),
      ],
    );
  }
}

class _NavItemData {
  final IconData icon;
  final IconData activeIcon;

  const _NavItemData({
    required this.icon,
    required this.activeIcon,
  });
}

class _NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final IconData activeIcon;
  final Function(int) onTap;

  const _NavItem({
    Key? key,
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.activeIcon,
    required this.onTap,
  }) : super(key: key);

  bool get _isSelected => index == currentIndex;

  Color _getColor() {
    return _isSelected ? AppColors.primaryBlue : Colors.grey[600]!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isSelected ? activeIcon : icon,
              color: _getColor(),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}