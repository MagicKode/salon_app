import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../config/theme/custom_colors.dart';
import '../../../../uikit/utils/masterCalendarDateFormater/calendar_date_formater.dart';

class CalendarHeaderSection extends StatelessWidget
    implements PreferredSizeWidget {
  final DateTime selectedDate;

  const CalendarHeaderSection({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    // Инициализируем локализацию (обычно это делают один раз в main.dart,
    initializeDateFormatting('ru', null);

    return AppBar(
      backgroundColor: colors.backgroundPrimary,
      elevation: 0,
      centerTitle: true,
      title: Text(
        AppStrings.titleMasterCalendar,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: colors.textPrimary,
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
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: colors.primaryBlue, // ✅ динамический синий
                  ),
                  const SizedBox(width: 8),
                  Text(
                    CalendarDateFormater.formatFullDate(selectedDate),
                    style: TextStyle(
                      fontSize: 15,
                      color: colors.primaryBlue, // ✅ динамический синий
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: colors.borderLight, thickness: 1, height: 1),
          ],
        ),
      ),
    );
  }

  // Обязательный параметр для AppBar
  @override
  Size get preferredSize => const Size.fromHeight(100); // Высота: заголовок + дата
}
