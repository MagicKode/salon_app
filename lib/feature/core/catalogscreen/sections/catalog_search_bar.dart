import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../../uikit/colors/app_colors.dart';

class CatalogSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const CatalogSearchBar({super.key, required this.controller, this.onChanged});

  @override
  State<CatalogSearchBar> createState() => _CatalogSearchBarState();
}

class _CatalogSearchBarState extends State<CatalogSearchBar> {
  @override
  void initState() {
    super.initState();
    // Слушаем изменения в контроллере, чтобы вовремя показать/скрыть крестик
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    // Перерисовываем виджет при изменении текста, чтобы обновить видимость крестика
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.primaryBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          autofocus: false,
          style: const TextStyle(fontSize: 15, color: AppColors.primaryBlack),
          decoration: InputDecoration(
            hintText: AppStrings.hintServiceMasterSearch,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: AppColors.primaryGrey,
            ),
            prefixIcon: const Icon(
              Icons.search,
              size: 20,
              color: AppColors.primaryBlue,
            ),

            // Динамический суффикс: если текст есть — показываем кликабельный крестик
            suffixIcon:
                widget.controller.text.isNotEmpty
                    ? IconButton(
                      icon: const Icon(
                        Icons.clear_rounded,
                        size: 20,
                        color: AppColors.primaryGrey,
                      ),
                      onPressed: () {
                        widget.controller
                            .clear(); // Полностью очищаем поле ввода
                      },
                    )
                    : null,

            // Если пусто — ничего не показываем справа
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
