import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/servicemenuscreen/sections/menubottombar/menu_bottom_bar.dart';
import 'package:salon_flutter/feature/servicemenuscreen/servicemenubody.dart';

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