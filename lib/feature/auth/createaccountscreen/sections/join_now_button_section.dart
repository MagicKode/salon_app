import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class JoinNowButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const JoinNowButton({
    Key? key,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
      ),
      child: Container(
        width: double.infinity, // Занимает всю доступную ширину
        height: 54, // Такая же высота как у полей ввода
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0), // Radius 50px
            ),
            elevation: 0, // Убираем тень
            padding: EdgeInsets.symmetric(vertical: 16.0), // Отступы внутри кнопки
          ),
          child: isLoading
              ? SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.5,
            ),
          )
              : Text(
            "Зарегестрироваться",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}