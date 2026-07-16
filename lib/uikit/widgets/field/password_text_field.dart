import 'package:flutter/material.dart';

import '../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? errorText;
  final ValueNotifier<bool>? visibilityNotifier;

  const PasswordTextField({
    super.key,
    required this.controller,
    this.hintText = 'Пароль',
    this.errorText,
    this.visibilityNotifier,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;
    final bool hasError = widget.errorText != null || _errorText != null;
    final Color errorColor = colors.statusError;

    return TextFormField(
      controller: widget.controller,
      onChanged: (value) {
        setState(() {
          _errorText = null;
        });
      },
      obscureText: _obscureText,
      style: TextStyle(
        fontSize: 16,
        color: colors.textSecondary, // ✅ тусклый цвет текста
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: colors.textHint),
        prefixIcon: Icon(Icons.lock_outline, color: colors.textSecondary),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: colors.textSecondary,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
            if (widget.visibilityNotifier != null) {
              widget.visibilityNotifier!.value = !_obscureText;
            }
          },
        ),
        errorText: widget.errorText ?? _errorText,
        errorStyle: TextStyle(fontSize: 12, color: errorColor),
        filled: true,
        fillColor: colors.surfaceInput,
        // ✅ динамический фон поля
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: errorColor, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: errorColor, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите пароль';
        }
        if (value.length < 6) {
          return 'Пароль должен содержать минимум 6 символов';
        }
        return null;
      },
    );
  }

  void setError(String error) {
    setState(() {
      _errorText = error;
    });
  }
}
