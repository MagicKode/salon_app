import 'package:flutter/material.dart';
import '../../../../../uikit/colors/app_colors.dart';
import '../../../../../uikit/assets/app_assets.dart'; // Путь к твоим ассетам
import '../../domain/entities/user_entity.dart';

class UserInfoSection extends StatelessWidget {
  final UserEntity user;

  const UserInfoSection({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ФОТО ПО ЦЕНТРУ
          CircleAvatar(
            radius: 70,
            backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
            // ЛОГИКА: Если есть avatarUrl (у мастера), берем его.
            // Если нет (у клиента), показываем иконку.
            backgroundImage: (user.avatarUrl != null && user.avatarUrl!.isNotEmpty)
                ? AssetImage(user.avatarUrl!) as ImageProvider
                : const AssetImage(AppAssets.pavelImg),
            child: (user.avatarUrl == null || user.avatarUrl!.isEmpty)
                ? const Icon(
              Icons.person_outline,
              size: 70,
              color: AppColors.primaryGrey,
            )
                : null,
          ),

          const SizedBox(height: 16),

          // ИМЯ ФАМИЛИЯ
          Text(
            user.fullName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlack,
            ),
          ),
          const SizedBox(height: 8),

          // ТЕЛЕФОН
          Text(
            user.phone,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.primaryGrey,
            ),
          ),
          const SizedBox(height: 4),

          // EMAIL
          Text(
            user.email,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.primaryGrey,
            ),
          ),
        ],
      ),
    );
  }
}
