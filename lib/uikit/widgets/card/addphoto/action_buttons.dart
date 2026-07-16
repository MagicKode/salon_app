import 'package:flutter/material.dart';

import '../../../../config/theme/custom_colors.dart';

class ActionButtons extends StatelessWidget {
  final bool isUploading;
  final bool hasImages;
  final VoidCallback onCancel;
  final VoidCallback onUpload;

  const ActionButtons({
    super.key,
    required this.isUploading,
    required this.hasImages,
    required this.onCancel,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: isUploading ? null : onCancel,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: colors.borderLight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                foregroundColor: colors.textSecondary,
              ),
              child: const Text('Отмена', style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: isUploading || !hasImages ? null : onUpload,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primaryBlue,
                foregroundColor: colors.textOnPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
              ),
              child:
                  isUploading
                      ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: colors.textOnPrimary,
                          strokeWidth: 2,
                        ),
                      )
                      : const Text(
                        'Загрузить',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
