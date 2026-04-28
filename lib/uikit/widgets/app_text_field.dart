import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final ValueNotifier<bool>? passwordVisibility;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.passwordVisibility,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Виджет сам следит за своим фокусом для перерисовки иконок и границ
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 54,
        child: ValueListenableBuilder<bool>(
          valueListenable: widget.passwordVisibility ?? ValueNotifier(true),
          builder: (context, isVisible, _) {
            return TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              obscureText: widget.isPassword ? !isVisible : false,
              decoration: InputDecoration(
                prefixIcon: Icon(widget.prefixIcon, color: hasFocus ? primary : inactive),
                suffixIcon: widget.isPassword ? _buildPasswordToggle(isVisible, hasFocus) : null,
                hintText: widget.hintText,
                hintStyle: TextStyle(color: hasFocus ? primary : Colors.grey[500]),
                enabledBorder: _buildBorder(inactive),
                focusedBorder: _buildBorder(primary),
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
    onPressed: () => widget.passwordVisibility!.value = !widget.passwordVisibility!.value,
  );
}
