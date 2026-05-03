import 'package:flutter/material.dart';

class NavItemModel {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const NavItemModel({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}