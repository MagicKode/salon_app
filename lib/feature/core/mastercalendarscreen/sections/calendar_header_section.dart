import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../../../uikit/utils/masterCalendarDateFormater/calendar_date_formater.dart';

class CalendarHeaderSection extends StatelessWidget
    implements PreferredSizeWidget {
  final DateTime selectedDate;

  const CalendarHeaderSection({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    // Инициализируем локализацию (обычно это делают один раз в main.dart,
    initializeDateFormatting('ru', null);

    return AppBar(
      backgroundColor: AppColors.primaryWhite,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        AppStrings.titleMasterCalendar,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.primaryBlack,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: AppColors.primaryBlue,
                  ),

                  const SizedBox(width: 8),

                  Text(
                    CalendarDateFormater.formatFullDate(selectedDate),
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: AppColors.lightBorder,
              thickness: 1,
              height: 1,
            ),
          ],
        ),
      ),
    );
  }

  // Обязательный параметр для AppBar
  @override
  Size get preferredSize => const Size.fromHeight(100); // Высота: заголовок + дата
}
