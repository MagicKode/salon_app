import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import '../domain/notification_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;

  const NotificationTile({super.key, required this.notification, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isUnread = !notification.isRead;

    // Парсим body для уведомлений о записи
    String clientLine = '';
    String bookingLine = '';
    if (notification.type == 'BOOKING_CREATED' ||
        notification.type == 'BOOKING_UPDATED') {
      final body = notification.body;
      // Ищем разделитель " записался на "
      final index = body.indexOf(' записался на ');
      if (index != -1) {
        clientLine = body.substring(0, index).trim(); // "Клиент +375..."
        bookingLine =
            body
                .substring(index + 1)
                .trim(); // "записался на 2026-07-08 в 09:00"
      } else {
        // fallback – показываем всё тело
        clientLine = body;
      }
    } else {
      // Для других типов уведомлений показываем тело как одну строку
      clientLine = notification.body;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color:
              isUnread
                  ? AppColors.primaryBlue.withValues(alpha: 0.2)
                  : Colors.grey.shade200,
          width: isUnread ? 1.5 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [

                // Иконка
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _accentColor(
                      notification.type,
                    ).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _typeIcon(notification.type),
                    size: 20,
                    color: _accentColor(notification.type),
                  ),
                ),
                const SizedBox(width: 12),

                // Текст
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Заголовок (оставляем как есть)
                      Text(
                        notification.title,
                        style: TextStyle(
                          fontWeight:
                              isUnread ? FontWeight.bold : FontWeight.w400,
                          fontSize: 14,
                          color:
                              isUnread ? Colors.black87 : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Тело уведомления – две строки
                      if (bookingLine.isNotEmpty) ...[
                        Text(
                          clientLine,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          bookingLine,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ] else ...[
                        Text(
                          clientLine,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),

                // Время и индикатор
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      notification.timeAgo,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    if (isUnread)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: _accentColor(notification.type),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _accentColor(String? type) {
    switch (type) {
      case 'BOOKING_CREATED':return Colors.green.shade600;
      case 'BOOKING_CANCELLED':return Colors.red.shade600;
      case 'BOOKING_UPDATED':return Colors.orange.shade700;
      default:return AppColors.primaryBlue;
    }
  }

  IconData _typeIcon(String? type) {
    switch (type) {
      case 'BOOKING_CREATED':return Icons.event_available;
      case 'BOOKING_CANCELLED':return Icons.event_busy;
      case 'BOOKING_UPDATED':return Icons.edit_calendar;
      default:return Icons.notifications_outlined;
    }
  }
}
