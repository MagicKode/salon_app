import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class SignInWithGoogleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const SignInWithGoogleButton({
    Key? key,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primaryBlue,
            side: BorderSide(
              color: AppColors.primaryBlue,
              width: 1.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0), // Radius 50px
            ),
            elevation: 0,
            // Убираем тень
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
            ), // Отступы внутри кнопки
          ),
          child:
              isLoading
                  ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.primaryBlue,
                      strokeWidth: 2.5,
                    ),
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Иконка Google
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/icons/google.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Image.asset(
                          'assets/icons/google.png',
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.g_mobiledata,
                              size: 24,
                              color: AppColors.primaryBlue,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 12.0), // Отступ между иконкой и текстом
                      Text(
                        "Sign In with Google",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
