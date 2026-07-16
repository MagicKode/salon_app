import 'package:flutter/material.dart';

import '../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final ValueNotifier<bool>? passwordVisibility;
  final TextInputType? keyboardType;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final String? Function(String?)? validator;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.passwordVisibility,
    this.keyboardType,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.validator,
    this.errorText,
    this.onChanged,
    this.focusNode,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    final bool hasFocus = _focusNode.hasFocus;
    final Color primary = colors.primaryBlue;
    final Color inactive = colors.textSecondary;
    final Color error = colors.statusError;
    final bool hasError =
        widget.errorText != null && widget.errorText!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 54,
        child: ValueListenableBuilder<bool>(
          valueListenable: widget.passwordVisibility ?? ValueNotifier(true),
          builder: (context, isVisible, _) {
            return TextFormField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              enabled: widget.enabled,
              maxLines: widget.maxLines ?? (widget.minLines != null ? null : 1),
              minLines: widget.minLines,
              obscureText: widget.isPassword ? !isVisible : false,
              keyboardType: widget.keyboardType,
              validator: widget.validator,
              onChanged: widget.onChanged,
              style: TextStyle(
                color: colors.textSecondary,
                // ✅ тусклый цвет текста (как в поиске)
                fontSize: 15,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  widget.prefixIcon,
                  color: hasFocus ? primary : (hasError ? error : inactive),
                ),
                suffixIcon:
                    widget.isPassword
                        ? _buildPasswordToggle(isVisible, hasFocus, colors)
                        : null,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: hasFocus ? primary : colors.textHint,
                ),
                errorText: widget.errorText,
                errorMaxLines: 1,
                errorStyle: TextStyle(fontSize: 12, color: error, height: 0.8),
                enabledBorder: _buildBorder(hasError ? error : inactive),
                focusedBorder: _buildBorder(primary),
                errorBorder: _buildBorder(error),
                focusedErrorBorder: _buildBorder(error),
                filled: true,
                fillColor: colors.surfaceInput,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(50.0),
    borderSide: BorderSide(color: color, width: 1.0),
  );

  Widget _buildPasswordToggle(
    bool isVisible,
    bool hasFocus,
    CustomColors colors,
  ) {
    return IconButton(
      icon: Icon(
        isVisible ? Icons.visibility : Icons.visibility_off,
        color: hasFocus ? colors.primaryBlue : colors.textSecondary,
      ),
      onPressed: () {
        if (widget.passwordVisibility != null) {
          widget.passwordVisibility!.value = !widget.passwordVisibility!.value;
        }
      },
    );
  }
}
