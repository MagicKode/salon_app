import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/homepagescreen/home_page_body.dart';

class HomePageScreen extends StatelessWidget {
  final bool isMaster;
  const HomePageScreen({
    super.key,
    required this.isMaster,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: HomePageBody(isMaster: isMaster),
    );
  }
}
