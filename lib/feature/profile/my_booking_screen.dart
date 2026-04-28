import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/profile/sections/booking_card.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text("My Bookings", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: 3, // Заглушка
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) => const BookingCard(),
      ),
    );
  }
}