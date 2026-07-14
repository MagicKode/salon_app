import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'history_card_status_chip.dart';

class HistoryCardHeader extends StatelessWidget {
  final String status;
  final bool isPast;
  final bool isCanceled;
  final bool canCancel;
  final VoidCallback onCancel;

  const HistoryCardHeader({
    super.key,
    required this.status,
    required this.isPast,
    required this.isCanceled,
    required this.canCancel,
    required this.onCancel,
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
          HistoryCardStatusChip(status: status, isPast: isPast),
          if (canCancel)
            _buildActionIcon(Icons.delete_outline, Colors.red, onCancel)
          else if (!isCanceled && !isPast && !canCancel)
            const Icon(Icons.lock_outline, color: Colors.grey, size: 18)
          else
            const SizedBox(width: 18),
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: color.withAlpha(30),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(icon, color: color, size: 18),
        ),
      ),
    );
  }

  Color _headerColor() {
    if (isCanceled) return Colors.red.withAlpha(20);
    if (isPast) return Colors.grey.withAlpha(13);
    return Colors.green.withAlpha(20);
  }
}
