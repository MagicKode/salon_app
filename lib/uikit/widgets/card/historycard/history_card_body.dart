import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salon_flutter/feature/checkout/domain/booking_entity.dart';

import '../../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов
import 'history_card_comment.dart';

class HistoryCardBody extends StatelessWidget {
  final BookingEntity booking;
  final List<String> servicesList;
  final String? currentNotes;
  final bool canEditComment;
  final bool isExpanded;
  final VoidCallback onEditComment;

  const HistoryCardBody({
    super.key,
    required this.booking,
    required this.servicesList,
    required this.currentNotes,
    required this.canEditComment,
    required this.isExpanded,
    required this.onEditComment,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    final dateStr = DateFormat(
      'd MMMM yyyy (EEEE)',
      'ru',
    ).format(booking.dateTime);
    final mainService = servicesList.isNotEmpty ? servicesList.first : 'Услуга';
    final extraCount = servicesList.length - 1;
    final servicesText =
        extraCount > 0 ? '$mainService + ещё $extraCount' : mainService;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Клиент
          Row(
            children: [
              Icon(
                Icons.person_outline,
                color: colors.primaryBlue, // ✅ динамический синий
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                booking.clientName.isNotEmpty ? booking.clientName : 'Клиент',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary, // ✅ динамический чёрный/белый
                ),
              ),
              const SizedBox(width: 4),
              if (booking.clientPhone.isNotEmpty)
                Text(
                  '(${booking.clientPhone})',
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.textSecondary, // ✅ динамический серый
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),

          // Услуги
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Icon(
                  Icons.content_cut,
                  color: colors.primaryBlue, // ✅ динамический синий
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  servicesText,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: colors.textPrimary, // ✅ динамический чёрный/белый
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Мастер
          Row(
            children: [
              Icon(
                Icons.assignment_ind,
                color: colors.primaryBlue, // ✅ динамический синий
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Мастер: ${booking.masterName}',
                style: TextStyle(
                  fontSize: 14,
                  color: colors.textPrimary, // ✅ динамический чёрный/белый
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Дата
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: colors.primaryBlue, // ✅ динамический синий
                size: 14,
              ),
              const SizedBox(width: 8),
              Text(
                dateStr,
                style: TextStyle(
                  fontSize: 14,
                  color: colors.textPrimary, // ✅ динамический чёрный/белый
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Время + Цена
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: colors.primaryBlue, // ✅ динамический синий
                size: 14,
              ),
              const SizedBox(width: 8),
              Text(
                _timeRange,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colors.textPrimary, // ✅ динамический чёрный/белый
                ),
              ),
              const Spacer(),
              if (booking.price > 0)
                Text(
                  '${booking.price} Br',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: colors.primaryBlue, // ✅ динамический синий
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Комментарий
          if (currentNotes?.trim().isNotEmpty == true)
            HistoryCardCommentRow(
              comment: currentNotes!.trim(),
              canEdit: canEditComment,
              isExpanded: isExpanded,
              onEdit: onEditComment,
            )
          else if (canEditComment)
            HistoryCardAddCommentButton(onTap: onEditComment),
        ],
      ),
    );
  }

  String get _timeRange {
    final start = booking.dateTime;
    final end = start.add(Duration(minutes: booking.durationMinutes));
    final s = '${start.hour}:${start.minute.toString().padLeft(2, '0')}';
    final e = '${end.hour}:${end.minute.toString().padLeft(2, '0')}';
    return '$s — $e';
  }
}
