import 'package:flutter/widgets.dart';

class ProfileActionEntity {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const ProfileActionEntity({
    required this.icon,
    required this.title,
    this.onTap,
  });
}
