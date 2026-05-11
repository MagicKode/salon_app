import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../uikit/colors/app_colors.dart';
import '../../../uikit/widgets/card/master_appointment_card.dart';
import 'domain/master_calendar_repository.dart';

class MasterCalendarBody extends StatelessWidget {
  const MasterCalendarBody({super.key});

  @override
  Widget build(BuildContext context) {
    final appointments = MasterCalendarRepository.getMockAppointments();

    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.coffee,
              size: 200,
              color: AppColors.primaryGrey.withOpacity(0.7),
            ),

            const SizedBox(height: 16),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                AppStrings.noClientsForToday,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.dateGrey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Если данные есть — показываем ListView (код остается прежним)
    return ListView.builder(
      padding: const EdgeInsets.only(top: 12, bottom: 20),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return MasterAppointmentCard(appointment: appointments[index]);
      },
    );
  }
}
