import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

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
    return TextFormField(
      controller: widget.controller,
      onChanged: (value) {
        setState(() {
          _errorText = null;
        });
      },
      obscureText: _obscureText,
      style: const TextStyle(fontSize: 16, color: AppColors.primaryBlack),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: AppColors.primaryGrey),
        prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primaryGrey),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: AppColors.primaryGrey,
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
