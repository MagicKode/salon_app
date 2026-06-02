import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/appinfo/version_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/auth/logout_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/legal/privacy_policy_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/support/share_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/support/support_section.dart';
import 'package:salon_flutter/feature/core/profilescreen/sections/userinfo/user_info_section.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../auth/authblock/bloc/auth_block.dart';
import '../../auth/authblock/bloc/auth_event.dart';
import '../../auth/authblock/bloc/auth_state.dart';
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
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) =>
          false, // Удаляет все предыдущие экраны, чтобы нельзя было вернуться назад кнопкой "Назад"
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is! AuthSuccess) {
          // Если стейт сменился на логаут или ошибку — улетаем на логин
          _navigateToLogin(context);
        }
      },

      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          // Проверяем авторизацию через состояние AuthBloc
          final bool isAuthorized = state is AuthSuccess;

          // Достаем токен или данные пользователя, если он авторизован
          // Если в AuthSuccess у тебя лежит объект User, используй его поля (state.user.name и т.д.)
          String firstName = "";
          String phone = "";
          String email = "";

          if (state is AuthSuccess) {
            final userModel = state.user;

            firstName = userModel.name;
            phone = userModel.phoneNumber;
            email = userModel.email;
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(height: 16),

              // 1. Секция ИНФО (всегда видна для демо)
              if (isAuthorized)
                UserInfoSection(
                  user: UserEntity(
                    firstName: firstName,
                    lastName: '',
                    phone: phone,
                    email: email,
                    avatarUrl: null,
                  ),
                ),

              const SizedBox(height: 50),

              // 2. Секция Поделиться приложением (всегда видна для демо)
              ShareSection(
                action: ProfileActionEntity(
                  icon: Icons.share_outlined,
                  title: AppStrings.shareApp ?? "Поделиться приложением",
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
              if (isAuthorized)
                LogoutSection(
                  // Отправляем событие логаута в БЛок, который очистит SecureStorage
                  onConfirm: () {
                    final authBloc = BlocProvider.of<AuthBloc>(context);
                    authBloc.add(AuthLogoutRequested());
                  },
                ),

              const SizedBox(height: 8),

              // 7. Версия
              const VersionSection(
                versionInfo: AppVersionEntity(
                  version: '1.0.1',
                  buildNumber: '27',
                ),
              ),

              const SizedBox(height: 8),
            ],
          );
        },
      ),
    );
  }
}
