import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/booking_service_body.dart';

import '../../../config/theme/custom_colors.dart';
import '../../../uikit/strings/app_strings.dart';
import '../../checkout/checkout_screen.dart';
import '../../checkout/domain/booking_entity.dart';
import '../catalogscreen/domain/catalog_service.dart';

class BookingServiceScreen extends StatefulWidget {
  // Добавляем обязательный параметр для передачи выбранных услуг
  final List<CatalogService> selectedServices;

  const BookingServiceScreen({super.key, required this.selectedServices});

  @override
  State<BookingServiceScreen> createState() => _BookingServiceScreenState();
}

class _BookingServiceScreenState extends State<BookingServiceScreen> {
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
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      backgroundColor: colors.backgroundPrimary,
      appBar: AppBar(
        title: Text(
          AppStrings.bookingTitle,
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: colors.backgroundPrimary,
        elevation: 0,
      ),
      body: BookingServiceBody(
        initialServices: widget.selectedServices,
        onBookPressed: (booking, services) {
          _showCheckoutBottomSheet(context, booking);
        },
      ),
    );
  }
}
