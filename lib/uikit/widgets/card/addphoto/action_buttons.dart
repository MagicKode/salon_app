import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: isUploading ? null : onCancel,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
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
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: AppColors.primaryWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
              ),
              child: isUploading
                  ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: AppColors.primaryWhite,
                  strokeWidth: 2,
                ),
              )
                  : const Text(
                'Загрузить',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
