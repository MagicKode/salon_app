import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../../../../feature/core/mastercalendarscreen/domain/appointment_model.dart';
import '../../dialog/delete_booking_dialog.dart';
import 'masterappointment/appointment_body.dart';
import 'masterappointment/appointment_expanded.dart';
import 'masterappointment/appointment_footer.dart';
import 'masterappointment/appointment_header.dart';

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
    final isCanceled = a.status?.toUpperCase() == 'CANCELED';
    final isPast = a.startTime.isBefore(DateTime.now());
    final canDelete = !isCanceled && !isPast;

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
                    : AppColors.primaryBlue.withAlpha(50),
            width: _isExpanded ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            MasterAppointmentHeader(
              status: a.status,
              isPast: isPast,
              isCanceled: isCanceled,
              canDelete: canDelete,
              onDelete: () => _confirmDelete(context),
            ),
            MasterAppointmentBody(
              appointment: a,
              isExpanded: _isExpanded,
              onEditComment: () {}, // пока ничего
            ),
            if (_isExpanded && canExpand)
              MasterAppointmentExpanded(appointment: a),
            if (canExpand)
              MasterAppointmentFooter(
                isExpanded: _isExpanded,
                onToggle: () => setState(() => _isExpanded = !_isExpanded),
              ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    DeleteBookingDialog.show(
      context,
      clientName: widget.appointment.displayClientName,
      onConfirm: widget.onDelete,
    );
  }
}
