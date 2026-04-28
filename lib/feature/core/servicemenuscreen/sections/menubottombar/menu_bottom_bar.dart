import 'package:flutter/material.dart';

import '../../../../../uikit/colors/app_colors.dart';

class MenuBottomBar extends StatelessWidget {
  const MenuBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32), // Увеличил отступ снизу для красоты
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          )
        ],
      ),
      child: Stack( // Используем Stack, чтобы кнопка чата была ровно по центру
        alignment: Alignment.center,
        children: [
          // 1. Основной контент (Цена слева и Кнопка справа)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Блок цены
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Total (1 Service)",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    "30 BYN",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryButtonColor,
                    ),
                  ),
                ],
              ),

              // Кнопка бронирования
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Book Now",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          // 2. Кнопка чата ровно по центру
          IconButton(
            onPressed: () {
              print("Open Chat");
            },
            icon: const Icon(
              Icons.chat,
              color: AppColors.primaryBlue,
              size: 28,
            ),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: AppColors.primaryBlue),
              padding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }
}