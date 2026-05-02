import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/booking_service_body.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/booking_bottom_bar.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../../../uikit/strings/app_strings.dart';
import '../../bookingcard/bookinghistory/feature/my_booking_checkout_screen.dart';

class BookingServiceScreen extends StatelessWidget {
  const BookingServiceScreen({super.key});

  void _showBookingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => const MyBookingCheckoutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        title: const Text(
          AppStrings.bookingTitle,
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
      ),
      body: const BookingServiceBody(),
      bottomNavigationBar: BookingBottomBar(
        onTap: () => _showBookingBottomSheet(context),
      ),
    );
  }
}
