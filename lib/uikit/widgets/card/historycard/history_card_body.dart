import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'package:salon_flutter/feature/checkout/domain/booking_entity.dart';
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
    final dateStr = DateFormat('d MMMM yyyy (EEEE)', 'ru')
        .format(booking.dateTime);
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
              const Icon(Icons.person_outline, color: AppColors.primaryBlue, size: 16),
              const SizedBox(width: 8),
              Text(
                booking.clientName.isNotEmpty ? booking.clientName : 'Клиент',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 4),
              if (booking.clientPhone.isNotEmpty)
                Text(
                  '(${booking.clientPhone})',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
            ],
          ),
          const SizedBox(height: 10),

          // Услуги
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 1),
                child: Icon(Icons.content_cut, color: AppColors.primaryBlue, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  servicesText,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Мастер
          Row(
            children: [
              const Icon(Icons.assignment_ind, color: AppColors.primaryBlue, size: 16),
              const SizedBox(width: 8),
              Text('Мастер: ${booking.masterName}', style: const TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 8),

          // Дата
          Row(
            children: [
              const Icon(Icons.calendar_today, color: AppColors.primaryBlue, size: 14),
              const SizedBox(width: 8),
              Text(dateStr, style: const TextStyle(fontSize: 14, color: AppColors.primaryBlack)),
            ],
          ),
          const SizedBox(height: 8),

          // Время + Цена
          Row(
            children: [
              const Icon(Icons.access_time, color: AppColors.primaryBlue, size: 14),
              const SizedBox(width: 8),
              Text(_timeRange, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              const Spacer(),
              if (booking.price > 0)
                Text(
                  '${booking.price} Br',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
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
