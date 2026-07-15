import 'package:flutter/material.dart';

import 'infocardwidget/info_card_widget.dart';

class PositionedInfoCard extends StatelessWidget {
  final String address;

  const PositionedInfoCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 30,
      child: InfoCardWidget(address: address),
    );
  }
}
