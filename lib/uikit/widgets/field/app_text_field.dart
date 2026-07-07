import 'package:flutter/material.dart';
import '../../colors/app_colors.dart';

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
    this.onChanged
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
    final bool hasFocus = _focusNode.hasFocus;
    final primary = AppColors.primaryBlue;
    final inactive = Colors.grey[400]!;
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 54,
        child: ValueListenableBuilder<bool>(
          valueListenable: widget.passwordVisibility ?? ValueNotifier(true),
          builder: (context, isVisible, _) {
            return TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              enabled: widget.enabled,
              maxLines: widget.maxLines ?? (widget.minLines != null ? null : 1),
              minLines: widget.minLines,
              obscureText: widget.isPassword ? !isVisible : false,
              keyboardType: widget.keyboardType,
              validator: widget.validator,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                prefixIcon: Icon(widget.prefixIcon, color: hasFocus ? primary : (hasError ? AppColors.primaryRed : inactive)),
                suffixIcon: widget.isPassword ? _buildPasswordToggle(isVisible, hasFocus) : null,
                hintText: widget.hintText,
                hintStyle: TextStyle(color: hasFocus ? primary : Colors.grey[500]),
                errorText: widget.errorText,
                errorMaxLines: 1,
                errorStyle: const TextStyle(fontSize: 12, color: AppColors.primaryRed, height: 0.8),
                enabledBorder: _buildBorder(hasError ? AppColors.primaryRed : inactive),
                focusedBorder: _buildBorder(primary),
                errorBorder: _buildBorder(AppColors.primaryRed),
                focusedErrorBorder: _buildBorder(AppColors.primaryRed),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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

  Widget _buildPasswordToggle(bool isVisible, bool hasFocus) => IconButton(
    icon: Icon(
      isVisible ? Icons.visibility : Icons.visibility_off,
      color: hasFocus ? AppColors.primaryBlue : Colors.grey[400],
    ),
    onPressed: () {
      if (widget.passwordVisibility != null) {
        widget.passwordVisibility!.value = !widget.passwordVisibility!.value;
      }
    },
  );
}
