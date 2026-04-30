import 'package:flutter/material.dart';

import '../../domain/booking_history_model.dart';


class BookingCard extends StatelessWidget {
  final BookingHistoryModel booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const IconBox(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booking.serviceName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("Мастер: ${booking.masterName}", style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
              ),
              Text("${booking.price} BYN", style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1D4D4F))),
            ],
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(booking.formattedDate, style: const TextStyle(fontSize: 13)),
              StatusBadge(status: booking.status),
            ],
          ),
        ],
      ),
    );
  }
}

class IconBox extends StatelessWidget {
  const IconBox({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48, height: 48,
      decoration: BoxDecoration(color: const Color(0xFFF0F7F7), borderRadius: BorderRadius.circular(12)),
      child: const Icon(Icons.content_cut_rounded, color: Color(0xFF4CA6A8)),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final BookingStatus status;
  const StatusBadge({super.key, required this.status});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: status.color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
      child: Text(status.label, style: TextStyle(color: status.color, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }
}
