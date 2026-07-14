import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'appointment_status_chip.dart';

class MasterAppointmentHeader extends StatelessWidget {
  final String? status;
  final bool isPast;
  final bool isCanceled;
  final bool canDelete;
  final VoidCallback onDelete;

  const MasterAppointmentHeader({
    super.key,
    required this.status,
    required this.isPast,
    required this.isCanceled,
    required this.canDelete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
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
          AppointmentStatusChip(status: status),
          if (canDelete)
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: onDelete,
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

  Color _headerColor() {
    switch (status?.toUpperCase()) {
      case 'CONFIRMED':
        return Colors.green.withAlpha(20);
      case 'PENDING':
        return Colors.orange.withAlpha(20);
      case 'CANCELED':
        return Colors.red.withAlpha(20);
      default:
        return AppColors.primaryBlue.withAlpha(13);
    }
  }
}
