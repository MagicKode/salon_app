import 'package:flutter/material.dart';

import '../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов

class NotificationsButton extends StatelessWidget {
  final VoidCallback onTap;
  final int unreadCount;

  const NotificationsButton({
    super.key,
    required this.onTap,
    this.unreadCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.notifications_none_rounded,
            color: colors.primaryBlue, // ✅ динамический синий
            size: 30,
          ),
          onPressed: onTap,
        ),
        if (unreadCount > 0)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: colors.statusError, // ✅ динамический красный
                shape: BoxShape.circle,
                border: Border.all(
                  color: colors.textOnPrimary,
                  // ✅ динамический белый/контрастный
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
