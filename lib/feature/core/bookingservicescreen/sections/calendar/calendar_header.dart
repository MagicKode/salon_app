import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../uikit/colors/app_colors.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime focusedMonth;
  final VoidCallback onLeftChevronTap;
  final VoidCallback onRightChevronTap;

  const CalendarHeader({
    super.key,
    required this.focusedMonth,
    required this.onLeftChevronTap,
    required this.onRightChevronTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left, color: AppColors.primaryBlue),
          onPressed: onLeftChevronTap,
        ),
        Expanded(
          child: Text(
            DateFormat.yMMMM('ru_RU').format(focusedMonth),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right, color: AppColors.primaryBlue),
          onPressed: onRightChevronTap,
        ),
      ],
    );
  }
}
