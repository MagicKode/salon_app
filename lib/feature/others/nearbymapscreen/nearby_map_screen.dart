import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/others/nearbymapscreen/body.dart';

class NearbyMapScreen extends StatelessWidget {
  const NearbyMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NearbyMapBody(),
    );
  }
}
