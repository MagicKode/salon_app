import 'package:flutter/material.dart';
import '../../../../../uikit/widgets/profile/profile_menu_tile.dart';
import '../../domain/entities/profile_action_entity.dart';

class ShareSection extends StatelessWidget {
  final ProfileActionEntity action;

  const ShareSection({
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
