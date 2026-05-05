import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/booking_service_body.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../../../uikit/strings/app_strings.dart';
import '../../checkout/checkout_screen.dart';
import '../../checkout/domain/booking_entity.dart';

class BookingServiceScreen extends StatelessWidget {
  const BookingServiceScreen({super.key});

  void _showCheckoutBottomSheet(BuildContext context, BookingEntity booking) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CheckoutScreen(booking: booking),
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
      body: BookingServiceBody(
        onBookPressed: (booking, services) {
          _showCheckoutBottomSheet(context, booking);
        },
      ),
    );
  }
}
