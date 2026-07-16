import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../config/theme/custom_colors.dart';

class ImagePickerArea extends StatelessWidget {
  final List<File> images;
  final bool isUploading;
  final VoidCallback onPick;
  final void Function(int) onRemove;

  const ImagePickerArea({
    super.key,
    required this.images,
    required this.isUploading,
    required this.onPick,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: isUploading ? null : onPick,
        child: Container(
          height: images.isEmpty ? 140 : 120,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: images.isEmpty ? colors.borderLight : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
            color: images.isEmpty ? colors.surfaceInput : Colors.transparent,
          ),
          child:
              images.isEmpty
                  ? _buildEmptyState(colors)
                  : _buildImageList(colors),
        ),
      ),
    );
  }

  Widget _buildEmptyState(CustomColors colors) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_photo_alternate_outlined,
          size: 48,
          color: colors.textHint,
        ),
        const SizedBox(height: 8),
        Text(
          'Нажмите, чтобы выбрать фото',
          style: TextStyle(fontSize: 14, color: colors.textSecondary),
        ),
        const SizedBox(height: 4),
        Text(
          'можно выбрать несколько',
          style: TextStyle(fontSize: 12, color: colors.textHint),
        ),
      ],
    );
  }

  Widget _buildImageList(CustomColors colors) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  images[index],
                  width: 100,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () => onRemove(index),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: colors.textPrimary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: colors.textOnPrimary,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
