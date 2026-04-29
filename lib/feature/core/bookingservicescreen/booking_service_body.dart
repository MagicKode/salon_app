import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/date_selection_section.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/notes_section.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/order_summary_section.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/time_selection_section.dart';

class BookingServiceBody extends StatelessWidget {
  const BookingServiceBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OrderSummarySection(services: ["Woman Blunt Cut"]),
          const SizedBox(height: 24),

          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5'),
            ),
            title: Text("Ваш мастер: Павел Ярошенко", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Топ-стилист"),
          ),

          const SizedBox(height: 24),
          const DateSelectionSection(),
          const SizedBox(height: 24),
          const TimeSelectionSection(),
          const SizedBox(height: 24),
          const NotesSection(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
