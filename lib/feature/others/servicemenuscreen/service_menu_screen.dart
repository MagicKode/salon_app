import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/others/servicemenuscreen/sections/menu_bottom_bar.dart';
import 'package:salon_flutter/feature/others/servicemenuscreen/service_menu_body.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

class ServiceMenuScreen extends StatelessWidget {
  const ServiceMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          AppStrings.serviceMenuTitle,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade200, height: 1.0),
        ),
      ),
      body: const ServiceMenuBody(),
      bottomNavigationBar: const MenuBottomBar(),
    );
  }
}
