import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../uikit/colors/app_colors.dart';
import '../../../feature/core/mastercalendarscreen/domain/appointment_model.dart';
import '../dialog/delete_booking_dialog.dart';

class MasterAppointmentCard extends StatefulWidget {
  final AppointmentModel appointment;
  final VoidCallback onDelete;

  const MasterAppointmentCard({
    super.key,
    required this.appointment,
    required this.onDelete,
  });

  @override
  State<MasterAppointmentCard> createState() => _MasterAppointmentCardState();
}

class _MasterAppointmentCardState extends State<MasterAppointmentCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final a = widget.appointment;
    final canExpand = a.hasDetails;

    return GestureDetector(
      onTap:
          canExpand ? () => setState(() => _isExpanded = !_isExpanded) : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.boxDecorationColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                _isExpanded
                    ? AppColors.primaryBlue
                    : AppColors.primaryBlue.withOpacity(0.5),
            width: _isExpanded ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            // ✅ ХЕДЕР: статус + удаление
            _buildHeader(a),
            // ✅ ТЕЛО: услуги, клиент, дата, время, цена
            _buildBody(a),
            // ✅ РАСКРЫТЫЕ ДЕТАЛИ
            if (_isExpanded && canExpand) _buildExpanded(a),
            // ✅ ФУТЕР: Подробнее/Скрыть
            if (canExpand) _buildFooter(),
          ],
        ),
      ),
    );
  }

  // ─── ХЕДЕР ───────────────────────────────────
  Widget _buildHeader(AppointmentModel a) {
    final isCanceled = a.status?.toUpperCase() == 'CANCELED';
    final isPast = a.startTime.isBefore(DateTime.now());
    final canDelete = !isCanceled && !isPast;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _headerColor(a.status),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatusChip(a.status),
          if (canDelete)
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => _confirmDelete(context),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.delete_outline,
                    color: AppColors.primaryRed,
                    size: 23,
                  ),
                ),
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.delete_outline,
                color: AppColors.primaryGrey,
                size: 23,
              ),
            ),
        ],
      ),
    );
  }

  Color _headerColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'CONFIRMED':
        return Colors.green.withOpacity(0.08);
      case 'PENDING':
        return Colors.orange.withOpacity(0.08);
      case 'CANCELED':
        return Colors.red.withOpacity(0.08);
      default:
        return AppColors.primaryBlue.withOpacity(0.05);
    }
  }

  // ─── ТЕЛО ────────────────────────────────────
  Widget _buildBody(AppointmentModel a) {
    final dateStr = DateFormat('d MMMM yyyy', 'ru').format(a.startTime);
    final servicesText =
        a.servicesNames.length > 1
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
                      text: ' (${_formatPhone(a.clientPhone)})',
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

          //  Комментарий
          if (a.notes?.isNotEmpty == true)
            Row(
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
                    maxLines: _isExpanded ? null : 1,
                    overflow: _isExpanded ? null : TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 8),

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

  // ─── РАСКРЫТЫЕ ДЕТАЛИ ───────────────────────
  Widget _buildExpanded(AppointmentModel a) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          if (a.servicesNames.length > 1) ...[
            const Text(
              'Все услуги:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const SizedBox(height: 4),
            ...a.servicesNames.map(
              (s) => Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 2),
                child: Text('• $s', style: const TextStyle(fontSize: 13)),
              ),
            ),
          ],
          if (a.notes?.isNotEmpty == true) ...[
            const SizedBox(height: 8),
            const Text(
              'Заметка:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.boxDecorationColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                a.notes!,
                style: const TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ─── ФУТЕР ───────────────────────────────────
  Widget _buildFooter() {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withOpacity(0.03),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isExpanded ? 'Скрыть ▲' : 'Подробнее ▼',
              style: const TextStyle(
                color: AppColors.primaryBlue,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── СТАТУС ЧИП ─────────────────────────────
  Widget _buildStatusChip(String? status) {
    Color bg, text;
    String label;
    switch (status?.toUpperCase()) {
      case 'CONFIRMED':
        bg = Colors.green;
        text = Colors.white;
        label = 'Подтверждено';
        break;
      case 'PENDING':
        bg = Colors.orange;
        text = Colors.white;
        label = 'Ожидает';
        break;
      case 'CANCELED':
        bg = Colors.red;
        text = Colors.white;
        label = 'Отменено';
        break;
      default:
        bg = Colors.grey;
        text = Colors.white;
        label = 'Неизвестно';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
    );
  }

  // ─── ФОРМАТИРОВАНИЕ ТЕЛЕФОНА ────────────────
  String _formatPhone(String phone) {
    if (phone.length == 13 && phone.startsWith('+')) {
      return '+${phone.substring(1, 4)} (${phone.substring(4, 6)}) ${phone.substring(6, 9)}-${phone.substring(9, 11)}-${phone.substring(11)}';
    }
    return phone;
  }

  // ─── ДИАЛОГ УДАЛЕНИЯ ────────────────────────
  void _confirmDelete(BuildContext context) {
    DeleteBookingDialog.show(
      context,
      clientName: widget.appointment.displayClientName,
      onConfirm: widget.onDelete,
    );
  }
}
