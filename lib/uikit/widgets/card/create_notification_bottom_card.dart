import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов
import '../button/app_button.dart';

class CreateNotificationBottomSheet extends StatefulWidget {
  const CreateNotificationBottomSheet({super.key});

  @override
  State<CreateNotificationBottomSheet> createState() =>
      _CreateNotificationBottomSheetState();
}

class _CreateNotificationBottomSheetState
    extends State<CreateNotificationBottomSheet> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Container(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceCard,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Divider(thickness: 4, indent: 140, endIndent: 140),
          ),
          const SizedBox(height: 20),

          Text(
            AppStrings.extraNotifications,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _titleController,
            style: TextStyle(color: colors.textPrimary),
            decoration: InputDecoration(
              hintText: AppStrings.themeOfNotification,
              hintStyle: TextStyle(
                color: colors.textHint,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colors.borderLight),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colors.borderLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colors.primaryBlue, width: 2),
              ),
              filled: true,
              fillColor: colors.surfaceInput,
            ),
          ),
          const SizedBox(height: 12),

          TextField(
            controller: _bodyController,
            maxLines: 3,
            style: TextStyle(color: colors.textPrimary),
            decoration: InputDecoration(
              hintText: AppStrings.themeOfNotificationForClient,
              hintStyle: TextStyle(
                color: colors.textHint,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colors.borderLight),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colors.borderLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colors.primaryBlue, width: 2),
              ),
              filled: true,
              fillColor: colors.surfaceInput,
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            text: AppStrings.sendNotificationToAllClients,
            onPressed: () {
              // Здесь будет логика отправки через репозиторий
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppStrings.notificationSuccessfullySent,
                    style: TextStyle(color: colors.textOnPrimary),
                  ),
                  backgroundColor: colors.statusSuccess,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
