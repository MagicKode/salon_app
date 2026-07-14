import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import '../../../../../feature/core/mastercalendarscreen/domain/appointment_model.dart';
import '../../../../utils/formatphone/format_phone.dart';

class MasterAppointmentBody extends StatelessWidget {
  final AppointmentModel appointment;
  final bool isExpanded;
  final VoidCallback onEditComment; // если нужно редактировать комментарий

  const MasterAppointmentBody({
    super.key,
    required this.appointment,
    required this.isExpanded,
    required this.onEditComment,
  });

  @override
  Widget build(BuildContext context) {
    final a = appointment;
    final dateStr = DateFormat('d MMMM yyyy', 'ru').format(a.startTime);
    final servicesText = a.servicesNames.length > 1
        ? '${a.mainService} + ещё ${a.servicesNames.length - 1} услуги'
        : a.mainService;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Услуги
          Row(
            children: [
              const Icon(
                Icons.content_cut,
                color: AppColors.primaryBlue,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  servicesText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Клиент
          Row(
            children: [
              const Icon(
                Icons.person_outline,
                color: AppColors.primaryBlue,
                size: 16,
              ),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 14),
                  children: [
                    TextSpan(
                      text: a.displayClientName,
                      style: const TextStyle(color: AppColors.primaryBlack),
                    ),
                    const WidgetSpan(child: SizedBox(width: 8)),
                    TextSpan(
                      text: ' (${formatPhone(a.clientPhone)})',
                      style: TextStyle(
                        color: AppColors.primaryGrey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Комментарий (если есть)
          if (a.notes?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.chat_bubble_outline,
                    size: 14,
                    color: AppColors.primaryGrey,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      a.notes!,
                      maxLines: isExpanded ? null : 1,
                      overflow: isExpanded ? null : TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Дата
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                color: AppColors.primaryBlue,
                size: 14,
              ),
              const SizedBox(width: 8),
              Text(
                dateStr,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryBlack,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Время + Цена
          Row(
            children: [
              const Icon(
                Icons.access_time,
                color: AppColors.primaryBlue,
                size: 14,
              ),
              const SizedBox(width: 8),
              Text(
                a.timeRange,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (a.totalPrice > 0)
                Text(
                  a.priceDisplay,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
