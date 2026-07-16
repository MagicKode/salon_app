import 'package:flutter/material.dart';

import '../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов

class PhoneTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? errorText;
  final Function(String)? onChanged;

  const PhoneTextField({
    super.key,
    required this.controller,
    this.hintText = 'Номер телефона',
    this.errorText,
    this.onChanged,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
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
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      keyboardType: TextInputType.phone,
      style: TextStyle(
        fontSize: 16,
        color: colors.textSecondary, // ✅ тусклый цвет текста
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: colors.textHint),
        prefixIcon: Icon(Icons.phone_outlined, color: colors.textSecondary),
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
          return 'Введите номер телефона';
        }
        final cleaned = value.replaceAll(RegExp(r'[^0-9+]'), '');
        if (!cleaned.startsWith('+')) {
          return 'Номер должен начинаться с +';
        }
        final digits = cleaned.replaceAll('+', '');
        if (digits.length < 10 || digits.length > 15) {
          return 'Некорректная длина номера';
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
