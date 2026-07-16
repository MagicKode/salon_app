import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salon_flutter/feature/core/mastercalendarscreen/domain/appointment_model.dart';

import '../../../../../config/theme/custom_colors.dart';
import '../../../../utils/formatphone/format_phone.dart';

class MasterAppointmentBody extends StatelessWidget {
  final AppointmentModel appointment;
  final bool isExpanded;
  final VoidCallback onEditComment;

  const MasterAppointmentBody({
    super.key,
    required this.appointment,
    required this.isExpanded,
    required this.onEditComment,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    final a = appointment;
    final dateStr = DateFormat('d MMMM yyyy', 'ru').format(a.startTime);

    // ✅ Убираем дубли и создаём уникальный список
    final uniqueServices = a.servicesNames.toSet().toList();
    final servicesText =
        uniqueServices.length > 1
            ? '${uniqueServices.first} + ещё ${uniqueServices.length - 1} услуги'
            : (uniqueServices.isNotEmpty ? uniqueServices.first : 'Услуга');

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Услуги
          Row(
            children: [
              Icon(Icons.content_cut, color: colors.primaryBlue, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  servicesText,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Клиент
          Row(
            children: [
              Icon(Icons.person_outline, color: colors.primaryBlue, size: 16),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 14),
                  children: [
                    TextSpan(
                      text: a.displayClientName,
                      style: TextStyle(color: colors.textPrimary),
                    ),
                    const WidgetSpan(child: SizedBox(width: 8)),
                    TextSpan(
                      text: ' (${formatPhone(a.clientPhone)})',
                      style: TextStyle(
                        color: colors.textSecondary,
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
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 14,
                    color: colors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      a.notes!,
                      maxLines: isExpanded ? null : 1,
                      overflow: isExpanded ? null : TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Дата
          Row(
            children: [
              Icon(Icons.calendar_today, color: colors.primaryBlue, size: 14),
              const SizedBox(width: 8),
              Text(
                dateStr,
                style: TextStyle(fontSize: 14, color: colors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Время + Цена
          Row(
            children: [
              Icon(Icons.access_time, color: colors.primaryBlue, size: 14),
              const SizedBox(width: 8),
              Text(
                a.timeRange,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colors.textPrimary,
                ),
              ),
              const Spacer(),
              if (a.totalPrice > 0)
                Text(
                  a.priceDisplay,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: colors.primaryBlue,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
