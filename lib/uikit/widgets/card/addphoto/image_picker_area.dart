import 'dart:io';
import 'package:flutter/material.dart';

import '../../../colors/app_colors.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: isUploading ? null : onPick,
        child: Container(
          height: images.isEmpty ? 140 : 120,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: images.isEmpty ? Colors.grey.shade300 : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
            color: images.isEmpty ? Colors.grey.shade50 : Colors.transparent,
          ),
          child: images.isEmpty
              ? _buildEmptyState()
              : _buildImageList(),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add_photo_alternate_outlined, size: 48, color: Colors.grey.shade400),
        const SizedBox(height: 8),
        Text(
          'Нажмите, чтобы выбрать фото',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Text(
          'можно выбрать несколько',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
        ),
      ],
    );
  }

  Widget _buildImageList() {
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
                    decoration: const BoxDecoration(
                      color: AppColors.primaryBlack,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, color: AppColors.primaryWhite, size: 16),
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
