import 'package:flutter/material.dart';

import '../../../../../config/theme/custom_colors.dart';
import '../../../../../feature/core/mastercalendarscreen/domain/appointment_model.dart';

class MasterAppointmentExpanded extends StatelessWidget {
  final AppointmentModel appointment;

  const MasterAppointmentExpanded({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    final a = appointment;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: colors.divider), // ✅ динамическая граница
          // Все услуги
          if (a.servicesNames.length > 1) ...[
            Text(
              'Все услуги:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: colors.textPrimary, // ✅ динамический чёрный/белый
              ),
            ),
            const SizedBox(height: 4),
            ...a.servicesNames.toSet().map(
              (s) => Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 2),
                child: Text(
                  '• $s',
                  style: TextStyle(
                    fontSize: 13,
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ),
          ],
          // Заметка
          if (a.notes?.isNotEmpty == true) ...[
            const SizedBox(height: 8),
            Text(
              'Заметка:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: colors.textPrimary, // ✅ динамический чёрный/белый
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.surfaceCard, // ✅ динамический фон
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                a.notes!,
                style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: colors.textSecondary, // ✅ динамический серый
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
