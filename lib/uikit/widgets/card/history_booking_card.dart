import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../../uikit/colors/app_colors.dart';
import '../../../feature/checkout/domain/booking_entity.dart';
import '../../../feature/checkout/domain/repository/booking_repository.dart';
import '../dialog/cancel_booking_dialog.dart';
import '../dialog/edit_comment_dialog.dart';

class HistoryBookingCard extends StatefulWidget {
  final BookingEntity booking;
  final VoidCallback? onCancelSuccess;
  final VoidCallback? onUpdateSuccess;

  const HistoryBookingCard({
    super.key,
    required this.booking,
    this.onCancelSuccess,
    this.onUpdateSuccess,
  });

  @override
  State<HistoryBookingCard> createState() => _HistoryBookingCardState();
}

class _HistoryBookingCardState extends State<HistoryBookingCard> {
  bool _isExpanded = false;
  bool _isCollapsing = false;
  late String? _currentNotes;

  // ✅ Геттер для списка услуг
  List<String> get _servicesList {
    final dynamic data = widget.booking.serviceNames;
    if (data is List) {
      return data.map((e) => e.toString()).toList();
    }
    if (data is String) {
      return data.split(',').map((s) => s.trim()).toList();
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    _currentNotes = widget.booking.notes;
  }

  @override
  void didUpdateWidget(HistoryBookingCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.booking.notes != widget.booking.notes) {
      _currentNotes = widget.booking.notes;
    }
  }

  bool get _isCanceled => widget.booking.status?.toUpperCase() == 'CANCELED';
  bool get _isPast => widget.booking.dateTime.isBefore(DateTime.now());

  bool get _canCancel {
    if (_isCanceled || _isPast) return false;
    final hoursUntil = widget.booking.dateTime.difference(DateTime.now()).inHours;
    return hoursUntil > 12;
  }

  bool get _canEditComment => !_isCanceled && !_isPast;
  bool get _hasDetails => (_currentNotes?.isNotEmpty ?? false) || _servicesList.length > 1;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: _isCollapsing ? 0.0 : 1.0,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: Alignment.topCenter,
        child: _isCollapsing
            ? const SizedBox(height: 0, width: double.infinity)
            : Opacity(
          opacity: _isPast ? 0.5 : 1.0,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.boxDecorationColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isExpanded ? AppColors.primaryBlue : AppColors.primaryBlue.withOpacity(0.3),
                width: _isExpanded ? 1.5 : 1,
              ),
            ),
            child: Column(
              children: [
                _buildHeader(),
                _buildBody(),
                if (_isExpanded && _hasDetails) _buildExpanded(),
                if (_hasDetails) _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── ХЕДЕР ───────────────────────────────────
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _headerColor(),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatusChip(),
          if (_canCancel)
            _buildActionIcon(Icons.delete_outline, Colors.red, () {
              showDialog(
                context: context,
                builder: (_) => CancelBookingDialog(
                  bookingId: '${widget.booking.id}',
                  onCancelSuccess: () {
                    widget.onCancelSuccess?.call();
                    setState(() => _isCollapsing = true);
                  },
                ),
              );
            })
          else if (!_isCanceled && !_isPast && !_canCancel)
            const Icon(Icons.lock_outline, color: Colors.grey, size: 18)
          else
            const SizedBox(width: 18),
        ],
      ),
    );
  }

  // ─── ТЕЛО ────────────────────────────────────
  Widget _buildBody() {
    final dateStr = DateFormat('d MMMM yyyy (EEEE)', 'ru').format(widget.booking.dateTime);
    final mainService = _servicesList.isNotEmpty ? _servicesList.first : 'Услуга';
    final extraCount = _servicesList.length - 1;
    final servicesText = extraCount > 0 ? '$mainService + ещё $extraCount' : mainService;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Услуги
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 1),
                child: Icon(Icons.content_cut, color: AppColors.primaryBlue, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(servicesText, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15))),
            ],
          ),
          const SizedBox(height: 10),

          // Мастер
          Row(
            children: [
              const Icon(Icons.person_outline, color: AppColors.primaryBlue, size: 16),
              const SizedBox(width: 8),
              Text('Мастер: ${widget.booking.masterName}', style: const TextStyle(fontSize: 14)),
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
              if ((widget.booking.price ?? 0) > 0)
                Text('${widget.booking.price} Br', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
            ],
          ),
          const SizedBox(height: 12),

          // Комментарий
          if (_currentNotes?.isNotEmpty == true)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.chat_bubble_outline, size: 14, color: AppColors.primaryGrey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _currentNotes!,
                    maxLines: _isExpanded ? null : 1,                    // ✅ 1 строка или всё
                    overflow: _isExpanded ? null : TextOverflow.ellipsis, // ✅ многоточие
                    style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: AppColors.primaryBlack),
                  ),
                ),
                if (_canEditComment) ...[
                  const SizedBox(width: 8),
                  GestureDetector(onTap: _editComment, child: const Icon(Icons.edit, color: AppColors.primaryBlue, size: 18)),
                ],
              ],
            )
          else if (_canEditComment)
            GestureDetector(
              onTap: _editComment,
              child: const Row(
                children: [
                  Icon(Icons.add_comment_outlined, size: 14, color: AppColors.primaryBlue),
                  SizedBox(width: 6),
                  Text('Добавить комментарий', style: TextStyle(color: AppColors.primaryBlue, fontSize: 13)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ─── РАСКРЫТЫЕ ДЕТАЛИ ─────────────────────
  Widget _buildExpanded() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          if (_servicesList.length > 1) ...[
            const Text('Все услуги:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: 4),
            ..._servicesList.map(
                  (s) => Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 2),
                child: Text('• $s', style: const TextStyle(fontSize: 13)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ─── ФУТЕР ─────────────────────────────────
  Widget _buildFooter() {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withOpacity(0.03),
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_isExpanded ? 'Скрыть ▲' : 'Подробнее ▼', style: const TextStyle(color: AppColors.primaryBlue, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  // ─── СТАТУС ЧИП ───────────────────────────
  Widget _buildStatusChip() {
    String label;
    Color bg;
    switch (widget.booking.status?.toUpperCase()) {
      case 'CONFIRMED':
        label = _isPast ? 'Завершено' : 'Подтверждено';
        bg = Colors.green;
        break;
      case 'CANCELED':
        label = 'Отменено';
        bg = Colors.red;
        break;
      case 'PENDING':
        label = 'Ожидает';
        bg = Colors.orange;
        break;
      default:
        label = 'Неизвестно';
        bg = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
    );
  }

  Widget _buildActionIcon(IconData icon, Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: color.withOpacity(0.2),
        onTap: onTap,
        child: Padding(padding: const EdgeInsets.all(4), child: Icon(icon, color: color, size: 18)),
      ),
    );
  }

  void _editComment() async {
    final bookingRepository = context.read<BookingRepository>();
    final updated = await showDialog<String>(
      context: context,
      builder: (_) => EditCommentDialog(
        bookingId: '${widget.booking.id}',
        initialComment: _currentNotes ?? '',
        bookingRepository: bookingRepository,
        onUpdateSuccess: widget.onUpdateSuccess,
      ),
    );
    if (updated != null && mounted) {
      setState(() => _currentNotes = updated);
    }
  }

  String get _timeRange {
    final start = widget.booking.dateTime;
    final end = start.add(Duration(minutes: widget.booking.durationMinutes ?? 60));
    final s = '${start.hour}:${start.minute.toString().padLeft(2, '0')}';
    final e = '${end.hour}:${end.minute.toString().padLeft(2, '0')}';
    return '$s — $e';
  }

  Color _headerColor() {
    if (_isCanceled) return Colors.red.withOpacity(0.08);
    if (_isPast) return Colors.grey.withOpacity(0.05);
    return Colors.green.withOpacity(0.08);
  }
}
