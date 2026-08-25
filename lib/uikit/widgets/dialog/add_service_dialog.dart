import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salon_flutter/config/theme/custom_colors.dart';
import 'package:salon_flutter/feature/catalog/domain/repositories/catalog_repository.dart';

class AddServiceSheet extends StatefulWidget {
  final VoidCallback? onServiceAdded;

  const AddServiceSheet({super.key, this.onServiceAdded});

  @override
  State<AddServiceSheet> createState() => _AddServiceSheetState();
}

class _AddServiceSheetState extends State<AddServiceSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _durationController = TextEditingController();
  final _descriptionController = TextEditingController();

  File? _imageFile;
  bool _isLoading = false;

  // 👇 Вычисляемое свойство – активна ли форма
  bool get _isFormValid {
    final name = _nameController.text.trim();
    final price = _priceController.text.trim();
    final duration = _durationController.text.trim();
    return name.isNotEmpty &&
        price.isNotEmpty &&
        duration.isNotEmpty &&
        _imageFile != null;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _imageFile = File(picked.path));
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final repo = context.read<CatalogRepository>();
      String? imageId;

      // 1. Загружаем изображение, если выбрано
      if (_imageFile != null) {
        imageId = await repo.uploadServiceImage(_imageFile!);
      }

      // 2. Создаём услугу
      final newService = await repo.createService(
        name: _nameController.text.trim(),
        price: double.parse(_priceController.text),
        durationMinutes: int.parse(_durationController.text),
        description:
            _descriptionController.text.trim().isEmpty
                ? null
                : _descriptionController.text.trim(),
        imageId: imageId,
        // передаём ID загруженного изображения (если есть)
        categoryId: null,
        // при необходимости можно выбрать категорию
        sortOrder: 0,
      );

      // 3. Успешно – закрываем и обновляем
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Услуга добавлена!')));
        widget.onServiceAdded?.call();
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      decoration: BoxDecoration(
        color: colors.backgroundPrimary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.textHint,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Добавить услугу',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),

              // Изображение
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colors.surfaceInput,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colors.textHint.withOpacity(0.3)),
                  ),
                  child:
                      _imageFile != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(_imageFile!, fit: BoxFit.cover),
                          )
                          : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                size: 40,
                                color: colors.textHint,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Добавить фото',
                                style: TextStyle(color: colors.textHint),
                              ),
                            ],
                          ),
                ),
              ),
              const SizedBox(height: 16),

              // Название
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Название услуги'),
                validator:
                    (v) =>
                        v == null || v.trim().isEmpty
                            ? 'Введите название'
                            : null,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),

              // Цена
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Цена (BYN)'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Введите цену';
                  if (double.tryParse(v) == null) return 'Введите число';
                  return null;
                },
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),

              // Длительность
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(
                  labelText: 'Длительность (мин)',
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty)
                    return 'Введите длительность';
                  if (int.tryParse(v) == null) return 'Введите целое число';
                  return null;
                },
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),

              // Описание
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Описание (необязательно)',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // Кнопка
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: (_isFormValid && !_isLoading) ? _submit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primaryBlue,
                    foregroundColor: colors.textOnPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:
                      _isLoading
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                          : const Text('Добавить услугу'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _durationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
