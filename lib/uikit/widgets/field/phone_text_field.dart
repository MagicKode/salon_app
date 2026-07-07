import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

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
    return TextFormField(
      controller: widget.controller,
      onChanged: (value) {
        setState(() {
          _errorText = null; // сбрасываем ошибку при изменении
        });
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      keyboardType: TextInputType.phone,
      style: const TextStyle(fontSize: 16, color: AppColors.primaryBlack),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: AppColors.primaryGrey),
        prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.primaryGrey),
        errorText: widget.errorText ?? _errorText,
        errorStyle: const TextStyle(fontSize: 12, color: AppColors.primaryRed),
        filled: true,
        fillColor: AppColors.primaryBackgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryRed, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryRed, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите номер телефона';
        }
        // Удаляем пробелы и спецсимволы, оставляем только + и цифры
        final cleaned = value.replaceAll(RegExp(r'[^0-9+]'), '');
        if (!cleaned.startsWith('+')) {
          return 'Номер должен начинаться с +';
        }
        final digits = cleaned.replaceAll('+', '');
        if (digits.length < 10 || digits.length > 15) {
          return 'Некорректная длина номера';
        }
        return null; // валидно
      },
    );
  }

  // Метод для ручной установки ошибки извне
  void setError(String error) {
    setState(() {
      _errorText = error;
    });
  }
}
