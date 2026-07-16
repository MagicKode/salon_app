import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/theme/theme_cubit.dart';
import '../../../config/theme/custom_colors.dart';

class ThemeSelectionDialog extends StatelessWidget {
  const ThemeSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final cubit = context.watch<ThemeCubit>();
    final currentMode = cubit.state;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      constraints: const BoxConstraints(maxWidth: 300),
      backgroundColor: colors.backgroundPrimary,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Заголовок
            Text(
              'Тема оформления',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),

            // Светлая тема
            _buildThemeOption(
              context,
              icon: Icons.light_mode,
              label: 'Светлая',
              isSelected: currentMode == ThemeMode.light,
              onTap: () => cubit.setTheme(ThemeMode.light),
            ),
            const SizedBox(height: 8),

            // Тёмная тема
            _buildThemeOption(
              context,
              icon: Icons.dark_mode,
              label: 'Тёмная',
              isSelected: currentMode == ThemeMode.dark,
              onTap: () => cubit.setTheme(ThemeMode.dark),
            ),
            const SizedBox(height: 8),

            // Системная тема
            _buildThemeOption(
              context,
              icon: Icons.settings_overscan,
              label: 'Системная',
              isSelected: currentMode == ThemeMode.system,
              onTap: () => cubit.setTheme(ThemeMode.system),
            ),

            const SizedBox(height: 24),

            // Кнопка "Закрыть"
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(8),
                    splashColor: colors.primaryBlue.withOpacity(0.15),
                    highlightColor: colors.primaryBlue.withOpacity(0.05),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Text(
                        'Закрыть',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: colors.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
      BuildContext context, {
        required IconData icon,
        required String label,
        required bool isSelected,
        required VoidCallback onTap,
      }) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? colors.primaryBlue.withOpacity(0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected
                  ? colors.primaryBlue
                  : colors.borderLight,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? colors.primaryBlue : colors.textSecondary,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? colors.primaryBlue : colors.textPrimary,
                  ),
                ),
              ),
              // ✅ Радио-круг или галочка
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? colors.primaryBlue : colors.textHint,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: colors.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => const ThemeSelectionDialog(),
    );
  }
}
