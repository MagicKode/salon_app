import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../uikit/widgets/card/addphoto/action_buttons.dart';
import '../../../../../../uikit/widgets/card/addphoto/drag_handle.dart';
import '../../../../../../uikit/widgets/card/addphoto/header_widget.dart';
import '../../../../../../uikit/widgets/card/addphoto/image_picker_area.dart';
import '../../../../../../uikit/widgets/card/addphoto/progress_widget.dart';

class AddPhotoSheet extends StatefulWidget {
  final String uploadUrl;

  const AddPhotoSheet({super.key, required this.uploadUrl});

  @override
  State<AddPhotoSheet> createState() => _AddPhotoSheetState();

  static Future<bool?> show(BuildContext context, String uploadUrl) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.transparent,
      builder: (context) => AddPhotoSheet(uploadUrl: uploadUrl),
    );
  }
}

class _AddPhotoSheetState extends State<AddPhotoSheet> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];
  bool _isUploading = false;
  double _uploadProgress = 0.0;
  int _uploadedCount = 0;
  int _totalCount = 0;

  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(pickedFiles.map((f) => File(f.path)));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  Future<void> _uploadAllImages() async {
    if (_selectedImages.isEmpty) return;

    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
      _uploadedCount = 0;
      _totalCount = _selectedImages.length;
    });

    final Dio dio = Dio();
    int successCount = 0;
    int failCount = 0;

    for (int i = 0; i < _selectedImages.length; i++) {
      final file = _selectedImages[i];
      try {
        if (!await file.exists()) {
          failCount++;
          continue;
        }
        final formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            file.path,
            filename: 'photo_$i.jpg',
          ),
          'relatedType': 'gallery',
          'relatedId': 0,
        });

        await dio.post(
          widget.uploadUrl,
          data: formData,
          options: Options(
            contentType: 'multipart/form-data',
            headers: {'Accept': 'application/json'},
            sendTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          ),
        );
        successCount++;
      } catch (e) {
        failCount++;
      }

      setState(() {
        _uploadedCount = i + 1;
        _uploadProgress = _uploadedCount / _totalCount;
      });
    }

    setState(() => _isUploading = false);

    String message;
    if (failCount == 0) {
      message = '✅ Все $_totalCount фото успешно загружены!';
    } else {
      message =
          '⚠️ Загружено $successCount из $_totalCount, ошибок: $failCount';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: failCount == 0 ? Colors.green : Colors.orange,
        behavior: SnackBarBehavior.floating,
      ),
    );

    if (successCount > 0) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DragHandle(),
          const SizedBox(height: 16),
          HeaderWidget(
            count: _selectedImages.length,
            isUploading: _isUploading,
          ),
          const SizedBox(height: 16),
          ImagePickerArea(
            images: _selectedImages,
            isUploading: _isUploading,
            onPick: _pickImages,
            onRemove: _removeImage,
          ),
          if (_isUploading) ...[
            const SizedBox(height: 16),
            ProgressWidget(
              uploadedCount: _uploadedCount,
              totalCount: _totalCount,
              progress: _uploadProgress,
            ),
            const SizedBox(height: 8),
          ],
          ActionButtons(
            isUploading: _isUploading,
            hasImages: _selectedImages.isNotEmpty,
            onCancel: () => Navigator.pop(context, false),
            onUpload: _uploadAllImages,
          ),
        ],
      ),
    );
  }
}
