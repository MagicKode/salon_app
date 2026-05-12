import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../uikit/colors/app_colors.dart';
import '../../../uikit/widgets/card/master_appointment_card.dart';
import 'domain/appointment_model.dart';
import 'domain/master_calendar_repository.dart';

class MasterCalendarBody extends StatefulWidget {
  const MasterCalendarBody({super.key});

  @override
  State<MasterCalendarBody> createState() => _MasterCalendarBodyState();
}

class _MasterCalendarBodyState extends State<MasterCalendarBody> {
// 2. Храним список в состоянии экрана
  late List<AppointmentModel> _appointments;

  @override
  void initState() {
    super.initState();
    // Инициализируем данные при старте экрана
    _appointments = MasterCalendarRepository.getMockAppointments();
  }

  @override
  Widget build(BuildContext context) {
    if (_appointments.isEmpty) {
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
      itemCount: _appointments.length,
      itemBuilder: (context, index) {
        return MasterAppointmentCard(
          appointment: _appointments[index],
          onDelete: () {
            // 1. Логика удаления из списка данных
            setState(() {
              // Удаляем элемент по индексу
              _appointments.removeAt(index);
            });

            // 2. Опционально: показываем уведомление внизу
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(AppStrings.deletedSuccessfully),
                duration: Duration(seconds: 2),
                backgroundColor: AppColors.primaryRed,
              ),
            );
          },
        );
      },
    );
  }
}

