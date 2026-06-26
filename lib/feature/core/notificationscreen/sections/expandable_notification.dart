import 'package:flutter/material.dart';
import '../../../../uikit/colors/app_colors.dart';
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

    return GestureDetector(
      onTap: () {
        if (!n.isRead) widget.onRead(n.id);
        setState(() => _isExpanded = !_isExpanded);
      },
      child: Container(
        decoration: BoxDecoration(
          color: n.isRead ? AppColors.boxDecorationColor : AppColors.primaryBackgroundColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: n.isRead
                ? AppColors.primaryBlackShadow.withOpacity(0.3)
                : _borderColor(n.type),
            width: n.isRead ? 1 : 1.5,
          ),

          boxShadow: n.isRead ? null : [
            BoxShadow(
              color: _borderColor(n.type).withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Хедер
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: _headerColor(n.type),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: Row(
                children: [
                  _typeIcon(n.type),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _typeLabel(n.type),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: _typeColor(n.type),
                      ),
                    ),
                  ),
                  if (!n.isRead)
                    Container(
                      width: 8, height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryBlue,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
            // Тело
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    n.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: n.isRead ? AppColors.primaryBlack.withOpacity(0.6) : AppColors.primaryBlack,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 13, color: AppColors.primaryGrey),
                      const SizedBox(width: 4),
                      Text(n.timeAgo, style: TextStyle(color: AppColors.primaryGrey, fontSize: 12)),
                    ],
                  ),
                  if (_isExpanded) ...[
                    const Divider(height: 20),
                    Text(
                      n.body,
                      style: TextStyle(color: AppColors.primaryBlack.withOpacity(0.8), fontSize: 13, height: 1.5),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _headerColor(String? type) {
    switch (type) {
      case 'BOOKING_CREATED': return Colors.green.withOpacity(0.06);
      case 'BOOKING_CANCELLED': return Colors.red.withOpacity(0.06);
      case 'BOOKING_UPDATED': return Colors.orange.withOpacity(0.06);
      default: return AppColors.primaryBlue.withOpacity(0.06);
    }
  }

  Color _borderColor(String? type) {
    switch (type) {
      case 'BOOKING_CREATED': return Colors.green.withOpacity(0.4);
      case 'BOOKING_CANCELLED': return Colors.red.withOpacity(0.4);
      case 'BOOKING_UPDATED': return Colors.orange.withOpacity(0.4);
      default: return AppColors.primaryBlue.withOpacity(0.3);
    }
  }

  Color _typeColor(String? type) {
    switch (type) {
      case 'BOOKING_CREATED': return Colors.green.shade700;
      case 'BOOKING_CANCELLED': return Colors.red.shade700;
      case 'BOOKING_UPDATED': return Colors.orange.shade800;
      default: return AppColors.primaryBlue;
    }
  }

  Icon _typeIcon(String? type) {
    switch (type) {
      case 'BOOKING_CREATED': return Icon(Icons.check_circle_outline, size: 16, color: Colors.green.shade700);
      case 'BOOKING_CANCELLED': return Icon(Icons.cancel_outlined, size: 16, color: Colors.red.shade700);
      case 'BOOKING_UPDATED': return Icon(Icons.edit_outlined, size: 16, color: Colors.orange.shade800);
      default: return Icon(Icons.notifications_outlined, size: 16, color: AppColors.primaryBlue);
    }
  }

  String _typeLabel(String? type) {
    switch (type) {
      case 'BOOKING_CREATED': return 'Новая запись';
      case 'BOOKING_CANCELLED': return 'Запись отменена';
      case 'BOOKING_UPDATED': return 'Запись изменена';
      default: return 'Уведомление';
    }
  }
}
