import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import '../../domain/booking_history_model.dart';

class BookingCard extends StatelessWidget {
  final BookingHistoryModel booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryBlue.withOpacity(0.15),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.content_cut_rounded, color: AppColors.primaryBlue, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.serviceName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      "Мастер: ${booking.masterName}",
                      style: TextStyle(color: AppColors.primaryBlue.withOpacity(0.6), fontSize: 12),
                    ),
                  ],
                ),
              ),
              // БЛОК ЦЕНЫ И ОПЛАТЫ
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(Icons.payments_outlined, size: 12, color: AppColors.primaryBlue.withOpacity(0.5)),
                      const SizedBox(width: 4),
                      Text(
                        "${booking.price} BYN",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                booking.formattedDate,
                style: TextStyle(fontSize: 11, color: AppColors.primaryGrey),
              ),
              StatusBadge(status: booking.status),
            ],
          ),
        ],
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final BookingStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: status.color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),

        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1.0,
        ),
      ),
      child: Text(
        status.label.toUpperCase(),
        style: TextStyle(
          color: status.color,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
