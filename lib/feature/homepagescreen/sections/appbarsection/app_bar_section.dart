import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class AppBarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 16.0, // Отступ заголовка слева
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Привет, Гость',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            "Выберите желаемый сервис",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.search_rounded, color: Colors.white, size: 24),
              padding: EdgeInsets.zero,
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
