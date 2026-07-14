import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../../../../../feature/core/mastercalendarscreen/domain/appointment_model.dart';
class MasterAppointmentExpanded extends StatelessWidget {
  final AppointmentModel appointment;

  const MasterAppointmentExpanded({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final a = appointment;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          // Все услуги
          if (a.servicesNames.length > 1) ...[
            const Text(
              'Все услуги:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const SizedBox(height: 4),
            ...a.servicesNames.map(
                  (s) => Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 2),
                child: Text('• $s', style: const TextStyle(fontSize: 13)),
              ),
            ),
          ],
          // Заметка
          if (a.notes?.isNotEmpty == true) ...[
            const SizedBox(height: 8),
            const Text(
              'Заметка:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.boxDecorationColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                a.notes!,
                style: const TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
