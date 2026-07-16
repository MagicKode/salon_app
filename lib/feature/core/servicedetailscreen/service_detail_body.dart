import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/catalog/domain/repositories/catalog_repository.dart';
import 'package:salon_flutter/feature/core/servicedetailscreen/domain/service_detail_data.dart';
import 'package:salon_flutter/feature/core/servicedetailscreen/sections/serviceimageheader/service_image_header_section.dart';
import 'package:salon_flutter/feature/core/servicedetailscreen/sections/serviceinfo/service_info_section.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import 'package:salon_flutter/uikit/widgets/button/app_button.dart';

import '../../../../config/theme/custom_colors.dart';
import '../../catalog/data/models/service_dto.dart';
import '../catalogscreen/domain/catalog_service.dart';

class ServiceDetailBody extends StatefulWidget {
  final ServiceDetail service;
  final bool isMaster;
  final Function(CatalogService selectedService)? onServiceSelected;
  final VoidCallback? onServiceUpdated;
  final VoidCallback? onBookPressed; // ✅ новый колбэк

  const ServiceDetailBody({
    super.key,
    required this.service,
    required this.isMaster,
    this.onServiceSelected,
    this.onServiceUpdated,
    this.onBookPressed,
  });

  @override
  State<ServiceDetailBody> createState() => _ServiceDetailBodyState();
}

class _ServiceDetailBodyState extends State<ServiceDetailBody> {
  bool _isEditing = false;
  late TextEditingController _descriptionController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(
      text: widget.service.description,
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final service = widget.service;
    final isMaster = widget.isMaster;

    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundPrimary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ServiceImageHeaderSection(service: service),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ServiceInfoSection(service: service),
                      const Divider(height: 24),
                      _buildDescriptionSection(context, colors),
                      if (!isMaster) ...[
                        const SizedBox(height: 24),
                        AppButton(
                          text: AppStrings.bookNow,
                          onPressed: () {
                            final computedPrice =
                                double.tryParse(
                                  service.price.toString().replaceAll(
                                    RegExp(r'[^0-9.]'),
                                    '',
                                  ),
                                ) ??
                                0.0;

                            final selectedService = CatalogService(
                              id: service.title,
                              name: service.title,
                              price: computedPrice,
                              duration: '1 ч.',
                            );

                            // ✅ вызываем колбэк, если передан
                            if (widget.onBookPressed != null) {
                              widget.onBookPressed!();
                            } else if (widget.onServiceSelected != null) {
                              widget.onServiceSelected!(selectedService);
                            } else {
                              Navigator.pop(context, selectedService);
                            }
                          },
                        ),
                      ],
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionSection(BuildContext context, CustomColors colors) {
    final isMaster = widget.isMaster;
    final service = widget.service;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.descriptionHeader,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            if (isMaster && !_isEditing)
              Container(
                decoration: BoxDecoration(
                  color: colors.surfaceInput.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.edit, size: 18, color: colors.primaryBlue),
                  onPressed: () {
                    setState(() {
                      _isEditing = true;
                      _descriptionController.text = service.description;
                    });
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _focusNode.requestFocus();
                    });
                  },
                  padding: const EdgeInsets.all(6),
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (_isEditing)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: _descriptionController,
                focusNode: _focusNode,
                maxLines: 5,
                style: TextStyle(color: colors.textPrimary),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: colors.borderLight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: colors.borderLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: colors.primaryBlue, width: 2),
                  ),
                  hintText: 'Введите новое описание',
                  hintStyle: TextStyle(color: colors.textHint),
                  filled: true,
                  fillColor: colors.surfaceInput,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                      });
                    },
                    child: Text(
                      'Отмена',
                      style: TextStyle(color: colors.textSecondary),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _saveDescription,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primaryBlue,
                      foregroundColor: colors.textOnPrimary,
                    ),
                    child: const Text('Сохранить'),
                  ),
                ],
              ),
            ],
          )
        else
          Text(
            service.description,
            style: TextStyle(
              fontSize: 16,
              color: colors.textPrimary,
              height: 1.5,
            ),
          ),
      ],
    );
  }

  Future<void> _saveDescription() async {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final newDescription = _descriptionController.text.trim();
    if (newDescription.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Описание не может быть пустым',
            style: TextStyle(color: colors.textOnPrimary),
          ),
          backgroundColor: colors.statusError,
        ),
      );
      return;
    }

    try {
      final repo = context.read<CatalogRepository>();
      final allServices = await repo.getServices();
      final existing = allServices.firstWhere(
        (s) => s.id.toString() == widget.service.id,
        orElse: () => throw Exception('Услуга не найдена'),
      );

      final updatedService = ServiceDto(
        id: existing.id,
        name: existing.name,
        description: newDescription,
        price: existing.price,
        durationMinutes: existing.durationMinutes,
        categoryId: existing.categoryId,
        sortOrder: existing.sortOrder,
        image: existing.image,
      );

      await repo.updateService(updatedService);

      if (widget.onServiceUpdated != null) {
        widget.onServiceUpdated!();
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Ошибка сохранения: $e',
            style: TextStyle(color: colors.textOnPrimary),
          ),
          backgroundColor: colors.statusError,
        ),
      );
    }
  }
}
