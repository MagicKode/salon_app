import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

import '../../config/theme/custom_colors.dart';
import 'checkout_body.dart';
import 'domain/booking_entity.dart';

class CheckoutScreen extends StatelessWidget {
  final BookingEntity booking;

  const CheckoutScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: colors.backgroundPrimary,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(width: 40, height: 4, decoration: BoxDecoration(
              color: colors.textHint,
              borderRadius: BorderRadius.circular(2),
            )),
            Flexible(
              child: SingleChildScrollView(
                child: CheckoutBody(booking: booking),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
