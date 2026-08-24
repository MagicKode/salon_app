import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../../config/theme/custom_colors.dart';

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
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color searchBackgroundColor = isDark
        ? colors.surfaceInput
        : Colors.grey.shade200;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: searchBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          autofocus: false,
          style: TextStyle(
            fontSize: 15,
            color: colors.textSecondary,
          ),
          decoration: InputDecoration(
            hintText: AppStrings.hintServiceMasterSearch,
            hintStyle: TextStyle(
              fontSize: 14,
              color: colors.textHint,
            ),
            prefixIcon: Icon(
              Icons.search,
              size: 20,
              color: colors.primaryBlue,
            ),
            suffixIcon: widget.controller.text.isNotEmpty
                ? IconButton(
              icon: Icon(
                Icons.clear_rounded,
                size: 20,
                color: colors.textSecondary,
              ),
              onPressed: () {
                widget.controller.clear();
                // Оповещаем родителя о пустой строке
                widget.onChanged?.call('');
              },
            )
                : null,
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.transparent,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
