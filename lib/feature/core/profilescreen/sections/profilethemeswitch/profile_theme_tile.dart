import 'package:flutter/material.dart';

import '../../../../../uikit/widgets/dialog/theme_selection_dialog.dart';
import '../../../../../uikit/widgets/profile/profile_menu_tile.dart';

class ProfileThemeTile extends StatelessWidget {
  const ProfileThemeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileMenuTile(
      icon: Icons.color_lens_outlined,
      title: 'Тема',
      onTap: () => ThemeSelectionDialog.show(context),
    );
  }
}
