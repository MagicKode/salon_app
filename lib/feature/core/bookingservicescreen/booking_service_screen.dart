import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/booking_service_body.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/booking_bottom_bar.dart';

class BookingServiceScreen extends StatelessWidget {
  const BookingServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Booking', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: const BookingServiceBody(),
      bottomNavigationBar: const BookingBottomBar(),
    );
  }
}
