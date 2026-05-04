import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/appinfo/version_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/auth/login_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/auth/logout_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/legal/privacy_policy_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/support/share_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/support/support_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/theme/theme_selection_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/theme/theme_system_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/userinfo/user_info_section.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../auth/loginscreen/login_screen.dart';
import 'domain/entities/app_version_entity.dart';
import 'domain/entities/profile_action_entity.dart';
import 'domain/entities/user_entity.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Имитируем данные из домена (позже придет из Bloc/Provider)
    const bool isAuthorized = false;

    // Метод навигации вынесен отдельно
    void _navigateToLogin(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const SizedBox(height: 32),
        // 1. Секция: ВОЙТИ
        LoginSection(
          isVisible: !isAuthorized,
          onTap: () => _navigateToLogin(context), // Передаем context в метод
        ),

        const SizedBox(height: 8),

        // 2. Секция ИНФО (всегда видна для демо)
        const UserInfoSection(
          user: UserEntity(
            firstName: 'Павел',
            lastName: 'Ярошенко',
            phone: '+375 (29) 123-45-67',
            email: 'pavel.yaroshenko@example.com',
          ),
        ),

        const SizedBox(height: 8),

        // 3. Секция Поделиться приложением (всегда видна для демо)
        ShareSection(
          action: ProfileActionEntity(
            icon: Icons.share_outlined,
            title: AppStrings.shareApp,
            onTap: () {
              // Логика Share (будет позже)
              print("Нажали: Поделиться");
            },
          ),
        ),

        const SizedBox(height: 8),

        // 4. СЕКЦИЯ СЛУЖБА ПОДДЕРЖКИ
        SupportSection(
          action: ProfileActionEntity(
            icon: Icons.headset_mic_outlined,
            title: AppStrings.supportTeam,
            onTap: () {
              // Здесь будет логика открытия чата или почты
              print("Нажали: Служба поддержки");
            },
          ),
        ),

        const SizedBox(height: 8),

        // 5. СИСТЕМНАЯ ТЕМА
        ThemeSystemSection(
          isActive: true, // Демо
          onChanged: (val) => print("Системная тема: $val"),
        ),

        const SizedBox(height: 8),

        // 6. СВЕТЛАЯ ТЕМА
        ThemeSelectionSection(
          title: AppStrings.lightTheme,
          isSelected: false, // Демо
          onTap: () => print("Выбрана светлая тема"),
        ),

        // 7. ТЕМНАЯ ТЕМА
        ThemeSelectionSection(
          title: AppStrings.darkTheme,
          isSelected: true, // Демо
          onTap: () => print("Выбрана темная тема"),
        ),

        const SizedBox(height: 8),

        // 8. СЕКЦИЯ ПОЛИТИКА КОНФИДЕНЦИАЛЬНОСТИ
        PrivacyPolicySection(
          action: ProfileActionEntity(
            icon: Icons.description_outlined,
            title: AppStrings.privacyPolicy,
            onTap: () {
              // Логика открытия документа (пока заглушка для демо)
              print("Нажали: Политика конфиденциальности");
            },
          ),
        ),

        const SizedBox(height: 8),

        //9. Секция Выход из аккаунта
        LogoutSection(
            onConfirm: () => _navigateToLogin(context)
        ),

        const SizedBox(height: 4),

        // 10. Версия
        const VersionSection(
          versionInfo: AppVersionEntity(version: '1.0.1', buildNumber: '27'),
        ),

        const SizedBox(height: 8),
      ],
    );
  }
}
