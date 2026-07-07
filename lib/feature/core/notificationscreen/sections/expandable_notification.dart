import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
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
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final n = widget.notification;
    final isUnread = !n.isRead;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isUnread ? _accentColor(n.type) : Colors.grey.shade200,
          width: isUnread ? 1.5 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (!n.isRead) widget.onRead(n.id);
            setState(() => _isExpanded = !_isExpanded);
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Верхняя строка: иконка, тип, время, статус
                Row(
                  children: [
                    // Иконка типа
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: _accentColor(n.type).withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _typeIcon(n.type),
                        size: 18,
                        color: _accentColor(n.type),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Тип уведомления
                    Expanded(
                      child: Text(
                        _typeLabel(n.type),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: _accentColor(n.type),
                        ),
                      ),
                    ),
                    // Время
                    Text(
                      n.timeAgo,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Индикатор непрочитанного
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _accentColor(n.type),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                // Заголовок
                Text(
                  n.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isUnread ? Colors.black87 : Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 6),
                // Краткое тело (всегда показываем первую строку)
                Text(
                  n.body,
                  maxLines: _isExpanded ? null : 2,
                  overflow: _isExpanded ? null : TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: isUnread ? Colors.black54 : Colors.grey.shade500,
                    height: 1.4,
                  ),
                ),
                // Развернутая часть
                if (_isExpanded) ...[
                  const SizedBox(height: 12),
                  Divider(color: Colors.grey.shade200, height: 1),
                  const SizedBox(height: 12),
                  // Дополнительная информация (можно добавить)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.chevron_right,
                        size: 16,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Скрыть ▲',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _accentColor(String? type) {
    switch (type) {
      case 'BOOKING_CREATED':
        return Colors.green.shade600;
      case 'BOOKING_CANCELLED':
        return Colors.red.shade600;
      case 'BOOKING_UPDATED':
        return Colors.orange.shade700;
      default:
        return AppColors.primaryBlue;
    }
  }

  IconData _typeIcon(String? type) {
    switch (type) {
      case 'BOOKING_CREATED':
        return Icons.event_available;
      case 'BOOKING_CANCELLED':
        return Icons.event_busy;
      case 'BOOKING_UPDATED':
        return Icons.edit_calendar;
      default:
        return Icons.notifications_outlined;
    }
  }

  String _typeLabel(String? type) {
    switch (type) {
      case 'BOOKING_CREATED':
        return 'Новая запись';
      case 'BOOKING_CANCELLED':
        return 'Запись отменена';
      case 'BOOKING_UPDATED':
        return 'Запись изменена';
      default:
        return 'Уведомление';
    }
  }
}
