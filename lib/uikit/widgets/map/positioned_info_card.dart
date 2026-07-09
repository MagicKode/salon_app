import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../feature/core/nearbymapscreen/domain/location_model.dart';
import 'infocardwidget/info_card_widget.dart';

class PositionedInfoCard extends StatelessWidget {
  final LocationModel shopLocation;

  const PositionedInfoCard({super.key, required this.shopLocation});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 30,
      child: InfoCardWidget(shopLocation: shopLocation),
    );
  }
}
