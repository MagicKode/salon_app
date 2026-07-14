import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/checkout/domain/booking_entity.dart';
import 'package:salon_flutter/feature/checkout/domain/repository/booking_repository.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../../../dialog/cancel_booking_dialog.dart';
import '../../../dialog/edit_comment_dialog.dart';
import '../history_card_body.dart';
import '../history_card_expanded.dart';
import '../history_card_footer.dart';
import '../history_card_header.dart';

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

  List<String> get _servicesList =>
      widget.booking.services.map((s) => s.name).toSet().toList();

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

  bool get _isCanceled => widget.booking.status.toUpperCase() == 'CANCELED';

  bool get _isPast => widget.booking.endTime.isBefore(DateTime.now());

  bool get _canCancel {
    if (_isCanceled || _isPast) return false;
    final hoursUntil =
        widget.booking.dateTime.difference(DateTime.now()).inHours;
    return hoursUntil > 12;
  }

  bool get _canEditComment => !_isCanceled && !_isPast;

  bool get _hasDetails =>
      (_currentNotes?.trim().isNotEmpty ?? false) || _servicesList.length > 1;

  void _editComment() async {
    final repo = context.read<BookingRepository>();
    final updated = await showDialog<String>(
      context: context,
      builder:
          (_) => EditCommentDialog(
            bookingId: '${widget.booking.id}',
            initialComment: _currentNotes ?? '',
            bookingRepository: repo,
            onUpdateSuccess: widget.onUpdateSuccess,
          ),
    );
    if (updated != null && mounted) setState(() => _currentNotes = updated);
  }

  void _onCancel() {
    showDialog(
      context: context,
      builder:
          (_) => CancelBookingDialog(
            bookingId: '${widget.booking.id}',
            onCancelSuccess: () {
              widget.onCancelSuccess?.call();
              setState(() => _isCollapsing = true);
            },
          ),
    );
  }

  void _toggleExpand() => setState(() => _isExpanded = !_isExpanded);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: _isCollapsing ? 0.0 : 1.0,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: Alignment.topCenter,
        child:
            _isCollapsing
                ? const SizedBox(height: 0, width: double.infinity)
                : Opacity(
                  opacity: _isPast ? 0.5 : 1.0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.boxDecorationColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            _isExpanded
                                ? AppColors.primaryBlue
                                : AppColors.primaryBlue.withAlpha(50),
                        width: _isExpanded ? 1.5 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        HistoryCardHeader(
                          status: widget.booking.status,
                          isPast: _isPast,
                          isCanceled: _isCanceled,
                          canCancel: _canCancel,
                          onCancel: _onCancel,
                        ),
                        HistoryCardBody(
                          booking: widget.booking,
                          servicesList: _servicesList,
                          currentNotes: _currentNotes,
                          canEditComment: _canEditComment,
                          isExpanded: _isExpanded,
                          onEditComment: _editComment,
                        ),
                        if (_isExpanded && _hasDetails)
                          HistoryCardExpanded(servicesList: _servicesList),
                        if (_hasDetails)
                          HistoryCardFooter(
                            isExpanded: _isExpanded,
                            onToggle: _toggleExpand,
                          ),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
