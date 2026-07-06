import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:salon_flutter/uikit/colors/app_colors.dart';

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
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
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

    int successCount = 0;
    int failCount = 0;

    for (int i = 0; i < _selectedImages.length; i++) {
      final file = _selectedImages[i];
      try {
        if (!await file.exists()) {
          print('❌ Файл не существует: ${file.path}');
          failCount++;
          continue;
        }
        final fileSize = await file.length();
        print('📁 Загружаем файл: ${file.path}, размер: $fileSize байт');

        // Создаём multipart запрос через http
        final request = http.MultipartRequest('POST', Uri.parse(widget.uploadUrl));
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
        request.fields['relatedType'] = 'gallery';
        request.fields['relatedId'] = '0';
        request.headers['Accept'] = 'application/json';

        print('🌐 Отправка запроса на: ${widget.uploadUrl}');
        print('📦 Поля: ${request.fields}');
        print('📎 Файл: ${request.files.first.filename}');

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        print('✅ Ответ: статус ${response.statusCode}, тело: ${response.body}');

        if (response.statusCode == 200) {
          successCount++;
        } else {
          failCount++;
          print('❌ Ошибка загрузки фото $i: статус ${response.statusCode}');
        }
      } catch (e) {
        failCount++;
        print('❌ Исключение при загрузке фото $i: $e');
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
      message = '⚠️ Загружено $successCount из $_totalCount, ошибок: $failCount';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: failCount == 0 ? Colors.green : Colors.orange,
      ),
    );

    if (successCount > 0) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Добавить фото в портфолио',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Выберите изображения (можно несколько)',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
          const SizedBox(height: 16),
          if (_selectedImages.isNotEmpty)
            Container(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedImages.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _selectedImages[index],
                          width: 100,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 4,
                        top: 4,
                        child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.close, color: AppColors.primaryWhite, size: 18),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          else
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('Нажмите кнопку "Выбрать фото", чтобы добавить изображения'),
              ),
            ),
          const SizedBox(height: 16),
          if (_isUploading) ...[
            LinearProgressIndicator(value: _uploadProgress),
            const SizedBox(height: 8),
            Text(
              'Загружено $_uploadedCount из $_totalCount',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
          ],
          Wrap(
            spacing: 6,
            runSpacing: 6,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _isUploading ? null : _pickImages,
                icon: const Icon(Icons.photo_library, size: 16),
                label: const Text('Выбрать фото', style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                  foregroundColor: AppColors.primaryBlack,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textStyle: const TextStyle(fontSize: 12),
                ),
              ),
              ElevatedButton(
                onPressed: _isUploading || _selectedImages.isEmpty ? null : _uploadAllImages,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: AppColors.primaryWhite,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textStyle: const TextStyle(fontSize: 12),
                ),
                child: _isUploading
                    ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(color: AppColors.primaryWhite, strokeWidth: 2),
                )
                    : const Text('Загрузить все', style: TextStyle(fontSize: 12)),
              ),
              TextButton(
                onPressed: _isUploading ? null : () => Navigator.pop(context, false),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Отмена', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
