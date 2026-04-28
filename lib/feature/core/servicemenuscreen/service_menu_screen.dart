import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/servicemenuscreen/sections/menubottombar/menu_bottom_bar.dart';
import 'package:salon_flutter/feature/core/servicemenuscreen/service_menu_body.dart';
class ServiceMenuScreen extends StatelessWidget {
  const ServiceMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text("Service Menu", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const ServiceMenuBody(),
      bottomNavigationBar: const MenuBottomBar(),
    );
  }
}