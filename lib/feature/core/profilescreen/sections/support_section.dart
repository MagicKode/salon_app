import 'package:flutter/material.dart';
import '../../../../uikit/widgets/profile_menu_tile.dart';
import '../domain/entities/profile_action_entity.dart';

class SupportSection extends StatelessWidget {
  final ProfileActionEntity action;

  const SupportSection({
    super.key,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileMenuTile(
      icon: action.icon,
      title: action.title,
      onTap: action.onTap,
    );
  }
}
