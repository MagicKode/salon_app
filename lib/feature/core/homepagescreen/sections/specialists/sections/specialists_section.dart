import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/specialists/specialists_body.dart';

import '../../../../../../uikit/strings/app_strings.dart';

class SpecialistsSection extends StatelessWidget {
  const SpecialistsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            AppStrings.ourMasters,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        // Используем Body, чтобы позже легко превратить его в List/Scroll
        const SpecialistsBody(),
      ],
    );
  }
}
