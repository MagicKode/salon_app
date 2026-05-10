import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/appinfo/version_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/auth/login_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/auth/logout_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/legal/privacy_policy_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/support/share_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/support/support_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/userinfo/user_info_section.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../auth/fakeauth/authservice/auth_service.dart';
import '../../auth/loginscreen/login_screen.dart';
import 'domain/entities/app_version_entity.dart';
import 'domain/entities/profile_action_entity.dart';
import 'domain/entities/user_entity.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    ).then(
      (_) => setState(() {}),
    ); // Обновляем профиль после возврата с экрана логина
  }

  void _handleLogout() {
    AuthService.currentUser = null; // Очищаем пользователя в мок-сервисе
    setState(() {}); // Перерисовываем экран
  }

  @override
  Widget build(BuildContext context) {
    // Получаем текущего пользователя из нашего AuthService
    final currentUser = AuthService.currentUser;
    final bool isAuthorized = currentUser != null;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const SizedBox(height: 8),

        // 1. Секция: ВОЙТИ
        LoginSection(
          isVisible: !isAuthorized,
          onTap: () => _navigateToLogin(context), // Передаем context в метод
        ),

        const SizedBox(height: 8),

        // 2. Секция ИНФО (всегда видна для демо)
        if (isAuthorized)
          UserInfoSection(
            user: UserEntity(
              firstName: currentUser.name,
              lastName: currentUser.role == 'master' ? 'Ярошенко' : '',
              phone: currentUser.phone,
              email: currentUser.email,
              avatarUrl: currentUser.avatarUrl, // Передаем аву из MockUser
            ),
          ),

        const SizedBox(height: 50),

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

        const SizedBox(height: 4),

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

        const SizedBox(height: 4),

        // 5. СЕКЦИЯ ПОЛИТИКА КОНФИДЕНЦИАЛЬНОСТИ
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

        const SizedBox(height: 50),

        // 6. Секция Выход из аккаунта
        if (isAuthorized) LogoutSection(onConfirm: _handleLogout),

        const SizedBox(height: 8),

        // 7. Версия
        const VersionSection(
          versionInfo: AppVersionEntity(version: '1.0.1', buildNumber: '27'),
        ),

        const SizedBox(height: 8),
      ],
    );
  }
}
