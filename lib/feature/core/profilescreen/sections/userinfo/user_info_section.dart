import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов
import '../../domain/entities/user_entity.dart';

class UserInfoSection extends StatelessWidget {
  final UserEntity user;

  const UserInfoSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: colors.textSecondary.withOpacity(0.2), // ✅ динамический серый с прозрачностью
            backgroundImage:
            (user.avatarUrl != null && user.avatarUrl!.isNotEmpty)
                ? AssetImage(user.avatarUrl!) as ImageProvider
                : null,
            child:
            (user.avatarUrl == null || user.avatarUrl!.isEmpty)
                ? Icon(
              Icons.person_outline,
              size: 70,
              color: colors.textSecondary, // ✅ динамический серый
            )
                : null,
          ),

          const SizedBox(height: 16),

          Text(
            user.fullName,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary, // ✅ динамический чёрный/белый
            ),
          ),
          const SizedBox(height: 8),

          Text(
            user.phone,
            style: TextStyle(
              fontSize: 14,
              color: colors.textSecondary, // ✅ динамический серый
            ),
          ),
          const SizedBox(height: 4),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.profileEmail,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colors.textSecondary, // ✅ динамический серый
                ),
              ),
              Text(
                user.email,
                style: TextStyle(
                  fontSize: 14,
                  color: colors.textSecondary, // ✅ динамический серый
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
