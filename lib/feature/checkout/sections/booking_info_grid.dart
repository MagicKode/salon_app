import 'package:flutter/material.dart';
import 'info_tile.dart';

class BookingInfoGrid extends StatelessWidget {
  final String date;
  final String time;
  final String master;
  final String duration;

  const BookingInfoGrid({
    super.key,
    required this.date,
    required this.time,
    required this.master,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3,
      children: [
        InfoTile(label: "Дата", value: date),
        InfoTile(label: "Время", value: time),
        InfoTile(label: "Мастер", value: master),
        InfoTile(label: "Длительность", value: duration),
      ],
    );
  }
}
