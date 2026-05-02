import 'package:flutter/material.dart';
import 'sections/profile_header_section.dart';
import 'sections/active_booking_section.dart';
import 'sections/profile_menu_section.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 70, 20, 24),
      children: const [
        ProfileHeaderSection(),
        SizedBox(height: 40),
        ActiveBookingSection(),
        SizedBox(height: 40),
        ProfileMenuSection(),
      ],
    );
  }
}
