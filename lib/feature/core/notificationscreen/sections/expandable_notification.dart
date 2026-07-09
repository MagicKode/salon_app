import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import '../../mastercalendarscreen/master_calendar_screen.dart';
import '../domain/notification_model.dart';

class ExpandableNotification extends StatefulWidget {
  final NotificationModel notification;
  final Function(int) onRead;

  const ExpandableNotification({
    super.key,
    required this.notification,
    required this.onRead,
  });

  @override
  State<ExpandableNotification> createState() => _ExpandableNotificationState();
}

class _ExpandableNotificationState extends State<ExpandableNotification> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final notification = widget.notification;
    final isUnread = !notification.isRead;

    // Парсим тело уведомления для записей
    String clientLine = '';
    String bookingLine = '';
    if (notification.type == 'BOOKING_CREATED' || notification.type == 'BOOKING_UPDATED') {
      final body = notification.body;
      final index = body.indexOf(' записался на ');
      if (index != -1) {
        clientLine = body.substring(0, index).trim();
        bookingLine = body.substring(index + 1).trim();
      } else {
        clientLine = body;
      }
    } else {
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
          color: isUnread ? AppColors.primaryGreen : AppColors.primaryGrey.withOpacity(0.2),
          width: isUnread ? 1.5 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // setState(() => _expanded = !_expanded);
            if (isUnread) widget.onRead(notification.id);
            // Переход на экран записей (замените на свой маршрут)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MasterCalendarScreen()),
            );

          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Иконка
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _accentColor(notification.type).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(_typeIcon(notification.type), size: 20, color: _accentColor(notification.type)),
                    ),
                    const SizedBox(width: 12),
                    // Основной текст
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Заголовок
                          Text(
                            notification.title,
                            style: TextStyle(
                              fontWeight: isUnread ? FontWeight.bold : FontWeight.w400,
                              fontSize: 14,
                              color: isUnread ? Colors.black87 : Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Тело: две строки или одна
                          if (bookingLine.isNotEmpty) ...[
                            Text(
                              clientLine,
                              style: const TextStyle(
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
                              color: AppColors.primaryGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                // Разворачиваемая часть (если нужно полное тело)
                if (_expanded && notification.body.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      notification.body,
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                    ),
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
      case 'BOOKING_CREATED': return Colors.green.shade600;
      case 'BOOKING_CANCELLED': return Colors.red.shade600;
      case 'BOOKING_UPDATED': return Colors.orange.shade700;
      default: return AppColors.primaryBlue;
    }
  }

  IconData _typeIcon(String? type) {
    switch (type) {
      case 'BOOKING_CREATED': return Icons.event_available;
      case 'BOOKING_CANCELLED': return Icons.event_busy;
      case 'BOOKING_UPDATED': return Icons.edit_calendar;
      default: return Icons.notifications_outlined;
    }
  }
}
