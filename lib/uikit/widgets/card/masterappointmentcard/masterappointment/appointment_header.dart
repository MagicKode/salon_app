import 'package:flutter/material.dart';

import '../../../../../config/theme/custom_colors.dart';
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
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _headerColor(colors),
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
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    Icons.delete_outline,
                    color: colors.statusError, // ✅ динамический красный
                    size: 23,
                  ),
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(
                Icons.delete_outline,
                color: colors.textSecondary, // ✅ динамический серый
                size: 23,
              ),
            ),
        ],
      ),
    );
  }

  Color _headerColor(CustomColors colors) {
    switch (status?.toUpperCase()) {
      case 'CONFIRMED':
        return colors.statusSuccess.withOpacity(0.08);
      case 'PENDING':
        return colors.statusWarning.withOpacity(0.08);
      case 'CANCELED':
        return colors.statusError.withOpacity(0.08);
      default:
        return colors.primaryBlue.withOpacity(0.05);
    }
  }
}
